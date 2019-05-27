Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'

    resource 'api/subjects',
      headers: :any,
      methods: :get
  end

  allow do
    origins '*'

    resource 'api/profile',
      headers: :any,
      methods: :post
  end
end
