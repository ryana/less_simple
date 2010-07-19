require File.join(File.dirname(__FILE__), 'test_helper')

class TestLessSimple < Test::Unit::TestCase

  should "have LessSimple" do
    assert LessSimple
  end

  context "On top of the I18n Simple backend" do

    should "default to Simple" do
      assert_equal I18n::Backend::Simple, LessSimple.klass
    end

    context "with a simple backend" do
      setup do
        @backend = LessSimple.factory_backend
        @backend.load_translations(File.join(File.dirname(__FILE__), 'en.yml'))
      end

      should "have interpolation_defaults" do
        assert @backend.respond_to?(:interpolation_defaults=)
        assert @backend.respond_to?(:interpolation_defaults)
      end

      should "still work" do
        assert_equal "Oh hi there", @backend.translate('en', 'welcome')
        assert_equal "MPB Party Planner", @backend.translate('en', 'site', :site_name => 'MPB')
      end

      should "still throw exceptions on missing values" do
        assert_raises I18n::MissingInterpolationArgument do
          puts @backend.translate('en', 'site')
        end
      end

      context "with defaults" do
        setup do
          @backend.interpolation_defaults = {:site_name => 'skin & bones'}
        end

        should "still work" do
          assert_equal "Oh hi there", @backend.translate('en', 'welcome')
          assert_equal "MPB Party Planner", @backend.translate('en', 'site', :site_name => 'MPB')
        end

        should "use defaults" do
          assert_equal 'skin & bones Party Planner', @backend.translate('en', 'site')
        end
      end
    end
  end
end
