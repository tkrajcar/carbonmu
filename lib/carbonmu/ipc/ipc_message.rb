require 'multi_json'

module CarbonMU
  class IPCMessage
    def self.valid_ops
      [:started, :command, :connect, :disconnect, :write, :reboot, :retrieve_existing_connections]
    end

    def self.required_parameters(op)
      {
        write: [:connection_id, :output],
        connect: [:connection_id],
        disconnect: [:connection_id],
        command: [:command, :connection_id],
      }[op]
    end

    def self.unserialize(text)
      hash_with_symbol_keys = Hash[MultiJson.load(text).map{|(k,v)| [k.to_sym,v]}]
      self.new(hash_with_symbol_keys[:op].to_sym, hash_with_symbol_keys)
    end

    attr_reader :params

    def initialize(op, options={})
      raise ArgumentError, "invalid op specified: #{op}" unless IPCMessage.valid_ops.include?(op)
      required_parameters = IPCMessage.required_parameters(op) || []
      provided_parameters = options.keys
      raise ArgumentError, "missing parameters for #{op} op: #{required_parameters - provided_parameters}" unless (required_parameters & provided_parameters).size == required_parameters.size
      @params = options.merge(op: op)
    end

    def method_missing(method_sym, *args, &block)
      @params.has_key?(method_sym) ? @params[method_sym] : super
    end

    def respond_to?(method_sym, include_private = false)
      @params.has_key?(method_sym) ? true : super
    end

    def serialize
      MultiJson.dump(params)
    end

    def to_s
      "<IPCMessage: #{params}>"
    end

    def ==(o)
      o.class == self.class && o.params == self.params
    end
    alias_method :eql?, :==
  end
end