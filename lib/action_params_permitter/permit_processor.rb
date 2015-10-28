require 'active_support/core_ext/module/delegation'

module ActionParamsPermitter
  #
  # Makes permitting process.
  # It can be done using income params from
  # your controller and builded permitter
  #
  # Parameters:
  # params - instance of ActionController::Parameters
  # builder - instance of Builders::Main
  #
  # Returns:
  # hash with permitted parameters
  #
  class PermitProcessor
    attr_reader :params, :builder

    delegate :state, to: :builder

    def initialize(params, builder)
      @params, @builder = params, builder
    end

    def call
      top_is_required? ? make_requiring : make_permitting
    end

    private

    def make_permitting
      params.permit(state)
    end

    def make_requiring
      required_resource = state.keys.first
      required_tail = state[required_resource]
      params.require(required_resource).permit(required_tail)
    end

    def top_is_required?
      builder.is_required
    end
  end
end
