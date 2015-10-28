module ActionParamsPermitter
  #
  # Entry for creating custom permitters
  #
  class Base
    def initialize(&block)
      builder.instance_eval(&block)
    end

    #
    # Provides hash that must be passed to `permit` method.
    #
    def hash_for_permitting
      builder.state
    end

    private

    def builder
      @_builder ||= Builders::Main.new({})
    end
  end
end
