ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
RSpec.configure do |config|
  # Use the specified formatter
  config.formatter = :documentation

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10
end
