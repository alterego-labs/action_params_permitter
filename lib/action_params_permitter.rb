require "action_params_permitter/version"

require 'active_support/dependencies/autoload'

require "action_params_permitter/errors"

module ActionParamsPermitter
  extend ActiveSupport::Autoload

  autoload :Base

  module Builders
    extend ActiveSupport::Autoload

    autoload :Main
    autoload :Resource

    module Concerns
      extend ActiveSupport::Autoload

      autoload :TopLevelResourceBlockExistenceChecking
      autoload :ResourceRequiring
    end
  end
end
