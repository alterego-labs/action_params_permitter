require 'spec_helper'

describe ActionParamsPermitter::PermitProcessor do
  subject(:processor) { described_class.new(params, builder) }

  let(:params) { ActionController::Parameters.new(raw_params) }
  let(:raw_params) { { tutorial: {param1: :value1, param2: :value2} } }

  let(:builder) { double(:builder, state: state, is_required: is_required) }

  context 'when top is required' do
    let(:state) { {tutorial: [:param1]} }
    let(:is_required) { true }

    it 'permits properly' do
      res = processor.call
      expect(res).to eq("param1" => :value1)
    end
  end

  context 'when top is not required' do
    let(:state) { {tutorial: [:param2]} }
    let(:is_required) { false }

    it 'permits properly' do
      res = processor.call
      expect(res).to eq("tutorial" => {"param2" => :value2})
    end
  end
end
