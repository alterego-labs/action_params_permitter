require 'spec_helper'

describe ActionParamsPermitter::Base do
  subject(:permitter) do
    ActionParamsPermitter::Base.new do
      resource :tutorial do
      end
    end
  end

  it { is_expected.to respond_to :hash_for_permitting }
  it { is_expected.to respond_to :permit }

  describe '#permit' do
    it 'calls permit processor correctly' do
      expect(ActionParamsPermitter::PermitProcessor).to(
        receive(:new)
        .with(:income_params, instance_of(ActionParamsPermitter::Builders::Main))
        .and_return(double(:permit_processor, call: nil))
      )
      permitter.permit(:income_params)
    end
  end
end
