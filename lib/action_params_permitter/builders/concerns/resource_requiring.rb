module ActionParamsPermitter
  module Builders
    module Concerns
      module ResourceRequiring
        def self.prepended(base)
          base.instance_eval do
            attr_reader :is_required
          end
        end

        def initialize(*params)
          @is_required = false
          super(*params)
        end

        def resource(name, options = {}, &block)
          @is_required = true if options.fetch(:required, false)
          check_double_requiring(options)
          super
        end

        private

        def check_double_requiring(options)
          return if !top_level_builder?
          return if !is_required
          return if !options[:required]
          raise ActionParamsPermitter::DoubleRequireError, 'You may define only one required top level resource!'
        end
      end
    end
  end
end
