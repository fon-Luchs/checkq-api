require 'rails_helper'

RSpec.describe SpecificationsController, type: :controller do
  describe "routing" do
    it { should route(:get, '/specifications').to(action: :show, controller: 'specifications') }
  end

  let(:headers) do
    {
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  describe '#index.json' do
    before { merge_headers headers }

    before { get :show, format: :json }

    it { should render_template :show }
  end
end
