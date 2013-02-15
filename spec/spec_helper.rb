require 'rubygems'

# Configure Rails Environment
ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../dummy/config/environment", __FILE__)

require 'rspec/rails'
require 'capybara/rspec'
require 'factory_girl_rails'

Rails.backtrace_cleaner.remove_silencers!

RSpec.configure do |config|
  config.mock_with :rspec
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end

# set javascript driver for capybara
Capybara.javascript_driver = :selenium

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories including factories.
([Rails.root.to_s] | ::Refinery::Plugins.registered.pathnames).map{|p|
  Dir[File.join(p, 'spec', 'support', '**', '*.rb').to_s]
}.flatten.sort.each do |support_file|
  require support_file
end

require 'vcr'
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr/'
  c.hook_into :webmock # or :fakeweb
  c.allow_http_connections_when_no_cassette = true
  c.configure_rspec_metadata!
  c.default_cassette_options = { :record => :new_episodes, :erb => true, :match_requests_on => [:path] }
end
