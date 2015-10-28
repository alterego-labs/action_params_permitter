require 'spec_helper'

describe ActionParamsPermitter::Builders::Resource do
  subject(:resource_builder) { described_class.new(name, state) }

  let(:name) { :tutorial }

  context 'when state is hash' do
    let(:state) { {} }

    context 'and block passed' do
      it 'builds properly' do
        result = resource_builder.call do
        end
        expect(result).to eq(tutorial: [])
      end
    end
  end

  context 'when state is array' do
    let(:state) { [] }

    context 'and no hash entry yet' do
      it 'builds properly' do
        result = resource_builder.call
        expect(result).to eq([{tutorial: []}])
      end
    end

    context 'and contains hash entry' do
      let(:state) { [:param1, resource2: :param3] }

      it 'builds properly' do
        result = resource_builder.call
        expect(result).to eq([:param1, resource2: :param3, tutorial: []])
      end
    end

    context 'and block passed' do
      it 'builds properly' do
        result = resource_builder.call do
          attribute :param1
        end
        expect(result).to eq([tutorial: [:param1]])
      end
    end

    context 'and without block' do
      it 'builds properly' do
        result = resource_builder.call
        expect(result).to eq([tutorial: []])
      end
    end
  end
end
