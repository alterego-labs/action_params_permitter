module ActionParamsPermitter
  module Builders
    #
    # Provides context for building permitters
    #
    # Parameters:
    # state - initial state for builder
    #
    class Main
      prepend Concerns::TopLevelResourceBlockExistenceChecking
      prepend Concerns::ResourceRequiring

      attr_reader :state

      def initialize(state)
        @state = state
      end

      #
      # Adds intention for resource permitting
      #
      # Parameters:
      # name - name of the permitting resource
      # options - hash with options. Available are:
      #   required - true/false. Required may be only top level resource and only one.
      #
      # Returns:
      # new state
      #
      def resource(name, options = {}, &block)
        Builders::Resource.new(name, state).call(&block)
      end

      #
      # Adds intention for attribute permitting
      #
      # Parameters:
      # name - name of the permitting attribute
      #
      # Returns:
      # new state
      #
      def attribute(name)
        state << name
        state
      end

      #
      # Adds intention for attributes permitting.
      # Works exactly as a `attribute` but accepts
      # array of attributes
      #
      # Parameters:
      # names - names of the permitting attributes
      #
      # Returns:
      # new state
      #
      def attributes(*names)
        names.each { |name| attribute(name) }
        state
      end

      private

      def top_level_builder?
        state.is_a?(Hash)
      end
    end
  end
end
