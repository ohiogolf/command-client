require "bundler/setup"
require "command/client"
require "vcr"
require "pry"

VCR.configure do |c|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :faraday
  c.configure_rspec_metadata!

  c.filter_sensitive_data("<COMPANY_NAME>") do
    Command::Client.company_name
  end

  c.filter_sensitive_data("<USER_NAME>") do
    Command::Client.user_name
  end

  c.filter_sensitive_data("<PASSWORD>") do
    # https://github.com/vcr/vcr/issues/433
    Command::Client.password.delete("!")
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
end
