module ActionParamsPermitter
  module Builders
    module Concerns
      module TopLevelResourceBlockExistenceChecking
        def resource(name, options = {}, &block)
          check_block_existence(&block)
          super
        end

        private

        def check_block_existence(&block)
          return if !top_level_builder?
          return if block_given?
          raise ActionParamsPermitter::TopLevelResourceWithoutBlockError, 'Top level resource must has block!'
        end
      end
    end
  end
end
