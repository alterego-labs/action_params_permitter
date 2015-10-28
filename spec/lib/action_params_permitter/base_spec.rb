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
end
