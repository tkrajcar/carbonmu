class MatchData
  def to_hash
    ret = Hash.new
    names.each { |k| ret[k.to_sym] = self[k] }
    return ret
  end
end
