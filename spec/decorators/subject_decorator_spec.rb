require 'rails_helper'

RSpec.describe SubjectDecorator do
  let(:sub) { create(:subject) }

  describe '#index' do
    subject      { sub.decorate.as_json }

    its([:id])   { sub.id }

    its([:name]) { sub.name }

    its([:question_count]) { sub.questions.count }

    its([:avatar])         { 'http://scp-wiki.wdfiles.com/local--files/scp-003/SCP-003a.jpg' }
  end
end
