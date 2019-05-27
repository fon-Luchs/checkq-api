class UserDecorator < Draper::Decorator
  delegate_all

  def as_json(*args)
    if context[:profile]
      {
        id: object.id,
        email: object.email,
        username: object.username,
        state: object.state,
        rate: 0
      }
    end
  end
end
