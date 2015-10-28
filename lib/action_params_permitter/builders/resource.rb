module ActionParamsPermitter
  module Builders
    #
    # Command class for building hash for permitting resource
    #
    # Parameters:
    # name - name of the building resource
    # state - current state of the builder
    #
    # Returns:
    # new state
    #
    class Resource
      attr_reader :name, :state

      def initialize(name, state)
        @name, @state = name, state
      end

      def call(&block)
        if hash_state?
          process_hash_state(&block)
        else
          process_array_state(&block)
        end
      end

      private

      def hash_state?
        state.is_a?(Hash)
      end

      def process_hash_state(&block)
        state[name] = gen_empty_builder(&block)
        state
      end

      def process_array_state(&block)
        sub_state = gen_sub_state(&block)
        if state_has_hash?
          child_hash.merge!(name => sub_state)
        else
          state << {name => sub_state }
        end
        state
      end

      def gen_sub_state(&block)
        block_given? ? gen_empty_builder(&block) : []
      end

      def gen_empty_builder(&block)
        Builders::Main.new([]).instance_eval(&block) || []
      end

      def child_hash
        state.detect {|el| el.is_a?(Hash)}
      end

      def state_has_hash?
        !child_hash.nil?
      end
    end
  end
end
