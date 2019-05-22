require 'rails_helper'

RSpec.describe SpecificationsController, type: :controller do
  describe "routing" do
    it { should route(:get, '/specifications').to(action: :show, controller: 'specifications') }
  end

  describe '#index.json' do
    before { get :show }

    it { should render_template :show }
  end
end
