gem 'activesupport', '2.3.5'
require 'active_support/vendor'

module I18n
  module Backend
    class LessSimple < Simple
      attr_accessor :interpolation_defaults

      def translate(locale, key, options = {})
        options = (interpolation_defaults || {}).merge options
        super locale, key, options
      end
    end
  end
end
