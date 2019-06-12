desc 'Generates jmeter test plan'
task :generate_jmeter_plan, [:url, :email, :password, :count] do |t, args|
  require 'ruby-jmeter'
  generate_report *extract_options_from(args)
end

def extract_options_from(args)
  defaults = {
    url: 'http://localhost:3000',
    email: 'user@example.com',
    password: 'password',
    count: 10
  }

  options = defaults.merge(args)
  [options[:url], options[:email], options[:password], options[:count].to_i]
end

def generate_report(url, email, password, count)
  uri = URI(url)
  domain, port = uri.host, uri.port
  test do
    threads count: count, duration: 30 do
      defaults domain: domain, port: port
      cookies policy: 'rfc2109', clear_each_iteration: true

      transaction 'Strona tagu' do
        visit name: '/feeds/tag/tag1', url: '/feeds/tag/tag1'
      end

      view_results_in_table
      view_results_tree
      #graph_results
      #aggregate_graph
    end
  end.jmx
end
