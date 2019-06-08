require 'rails_helper'

RSpec.describe Api::BanksController, type: :controller do
  describe "routs" do
    it { should route(:get, '/api/bank').to(action: :show, controller: 'api/banks') }
  end

  describe '#show.json' do
    before { get :show, format: :json }

    it { should render_template :show }
  end
end
