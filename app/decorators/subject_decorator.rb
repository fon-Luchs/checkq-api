class SubjectDecorator < ApplicationDecorator
  delegate_all

  def as_json(*args)
    {
      id: object.id,
      name: object.name,
      question_count: 777,
      avatar: 'http://scp-wiki.wdfiles.com/local--files/scp-003/SCP-003a.jpg'
    }
  end
end