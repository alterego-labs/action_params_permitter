require 'spec_helper'

describe ActionParamsPermitter::Builders::Main do
  subject(:base_builder) { described_class.new(state) }

  let(:state) { [] }

  it { is_expected.to respond_to :resource }
  it { is_expected.to respond_to :attribute }
  it { is_expected.to respond_to :attributes }

  describe '#attribute' do
    it 'modifies state properly' do
      expect(base_builder.state).to be_empty
      base_builder.attribute(:about)
      expect(base_builder.state).to include(:about)
    end
  end

  describe '#attributes' do
    it 'modifies state properly' do
      expect(base_builder.state).to be_empty
      base_builder.attributes(:about, :login)
      expect(base_builder.state).to include(:about, :login)
    end
  end
end
