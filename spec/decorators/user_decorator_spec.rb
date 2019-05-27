require 'rails_helper'

RSpec.describe UserDecorator do
  describe 'profile#as_json' do
    let(:profile) do
      create(
        :user, username: 'Остап Вишня',
               email: 'otap123@oda.com.ua'
      )
    end

    subject { profile.decorate(context: {profile: true}).as_json }

    its([:id])           { should eq profile.id }

    its([:username])     { should eq 'Остап Вишня' }

    its([:email])        { should eq 'otap123@oda.com.ua' }

    its([:rate])         { should eq 0 }

    its([:state])        { should eq 'user' }
  end
end
