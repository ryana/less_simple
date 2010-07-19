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

class LessSimple
  @@klass = I18n::Backend::Simple
  
  def self.klass= val
    @@klass = val
  end

  def self.klass
    @@klass
  end

  def self.factory_backend
    subclass.new
  end

  def self.subclass
    subclass = eval("class LessSimple::#{klass.to_s.gsub('::', '')} < #{klass}; self; end")

    subclass.class_eval do
      attr_accessor :interpolation_defaults
      include InstanceMethods
    end
  
    subclass
  end

  module InstanceMethods
    def translate(locale, key, options = {})
      options = (interpolation_defaults || {}).merge options
      super locale, key, options
    end
  end

end
