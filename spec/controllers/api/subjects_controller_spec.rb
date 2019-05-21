require 'rails_helper'

RSpec.describe Api::SubjectsController, type: :controller do
  describe 'routes tests' do
    it { should route(:get, 'api/subjects').to(action: :index, controller: 'api/subjects') }
  end
  
  let(:headers) do
    {
      'Content-type' => 'application/json',
      'Accept' => 'application/json'
    }
  end

  describe '#index.json' do
    before { merge_headers headers }

    before { get :index, format: :json }

    it { should render_template :index }
  end
end
