require_relative "../test_helper.rb"

class InternationalizationTest < Minitest::Test
  def setup
    Internationalization.setup
   @core_locales_dir = File.expand_path("../../../config/locales", __FILE__)

  end

  def test_includes_locales_dir_into_global_i18n_load_path
    assert_includes I18n.load_path, "#{@core_locales_dir}/en.yml"
  end

  def test_t_is_shortcut_for_i18n_t
    str = "foo"
    opts = { foo: "bar" }
    I18n.expects(:t).with(str, opts)

    Internationalization.t(str, opts)
  end
end
