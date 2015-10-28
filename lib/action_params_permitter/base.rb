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
    # Returns:
    # generated hash of permitter definition
    #
    def hash_for_permitting
      builder.state
    end

    #
    # Calls permitting income params using permitter definition
    #
    # Parameters:
    # params - instance of ActionController::Parameters
    #
    # Returns:
    # hash of permitted params
    #
    def permit(params)
      PermitProcessor.new(params, builder).call
    end

    private

    def builder
      @_builder ||= Builders::Main.new({})
    end
  end
end
