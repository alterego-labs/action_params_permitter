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
  end
end
