require 'spec_helper'

describe SayCommand do
  context "syntax" do
    it { expect(command_parse_results("say foo")).to eq(parse_to(SayCommand, {text: "foo"})) }

    it "requires an argument" do
      expect(command_parse_results("say")).to eq(parse_to(UnknownCommand))
    end
  end
end
