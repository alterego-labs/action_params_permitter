require 'spec_helper'

TutorialParamsPermitter = ActionParamsPermitter::Base.new do
  resource :tutorial do
    attribute :cost
    attributes :hours, :minutes
    resource :tool_ids
    resource :post_attributes do
      attribute :_destroy
    end
  end

  resource :question do
    attribute :answer_count
  end
end

describe ActionParamsPermitter::Base do
  context 'when many resources and attributes configured' do
    it 'builds hash for permitting properly' do
      hash_for_permitting = TutorialParamsPermitter.hash_for_permitting
      expect(hash_for_permitting).to eq(
        tutorial: [
          :cost, :hours, :minutes, tool_ids: [], post_attributes: [:_destroy]
        ],
        question: [:answer_count]
      )
    end
  end

  context 'when top level resource without block' do
    it 'raises error' do
      expect{
        TopLevelWithoutBlockPermitter = ActionParamsPermitter::Base.new do
          resource :without_block
        end
      }.to raise_error(ActionParamsPermitter::TopLevelResourceWithoutBlockError)
    end
  end
end
