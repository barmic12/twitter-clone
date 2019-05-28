# config/initializers/datadog-tracer.rb

Datadog.configure do |c|
  c.use :rails, service_name: 'my-rails-app'
  c.tracer env: 'acts-as-taggable-on', analytics_enabled: true
end
