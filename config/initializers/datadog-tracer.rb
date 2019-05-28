# config/initializers/datadog-tracer.rb

Datadog.configure do |c|
  c.use :rails, service_name: 'my-rails-app'
  c.tracer env: 'master', analytics_enabled: true
end
