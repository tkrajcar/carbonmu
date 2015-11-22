require_relative "test_helper.rb"
require "i18n/tasks"

class I18nKeysTest < Minitest::Test
  def setup
    @i18n = I18n::Tasks::BaseTask.new
  end

  def test_does_not_have_missing_keys
    assert_empty @i18n.missing_keys, "Missing #{@i18n.missing_keys.leaves.count} i18n keys, run `i18n-tasks missing' to show them"
  end
end
