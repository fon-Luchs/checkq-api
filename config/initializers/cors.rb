Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'

    resource 'api/subjects',
      headers: [ 'Content-type' => 'application/json', 'Accept' => 'application/json' ],
      methods: [:get, :post, :put, :patch, :delete, :options, :head]
  end
end
