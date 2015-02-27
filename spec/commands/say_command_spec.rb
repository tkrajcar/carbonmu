require 'spec_helper'

describe SayCommand do
  context "syntax" do
    it { command_parse_results("say foo").should eq(parse_to(SayCommand, {text: "foo"})) }

    it "requires an argument" do
      command_parse_results("say").should eq(parse_to(UnknownCommand))
    end
  end
end
