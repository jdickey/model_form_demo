
# test/test_helper.rb
#
# Sets up the supporting environment for testing our Rails code using SimpleCov,
# Capybara, and others.
#
# ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### #
#                         SECTION 1 OF 6: Preamble.                            #
#
# We force the setting of the `RAILS_ENV` variable for the duration of our
# tests.
ENV['RAILS_ENV'] ||= 'test'

# ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### #
#                     SECTION 2 OF 6: Coverage analysis.                       $
#
# Load SimpleCov if we're in a "test" environment (as we are by default). Also
# load CodeClimate test reporter if and only if a `CODECLIMATE_REPO_TOKEN`
# environment variable is set.
if ENV['RAILS_ENV'] == 'test'
  require 'simplecov'
  require 'minitest/autorun'

  uses_cova = ENV['COVERALLS_REPO_TOKEN']
  uses_cc = ENV['CODECLIMATE_REPO_TOKEN']
  if uses_cc
    require 'codeclimate-test-reporter'
    CodeClimate::TestReporter.start
  end
  SimpleCov.start 'rails' do
    add_filter '/vendor/'
    sc_formatters = [
      SimpleCov::Formatter::HTMLFormatter
    ]
    if uses_cova
      require 'coveralls'
      sc_formatters.unshift(Coveralls::SimpleCov::Formatter)
    end
    sc_formatters.unshift(CodeClimate::TestReporter::Formatter) if uses_cc
    self.formatters = sc_formatters
    # formatter SimpleCov::Formatter::MultiFormatter[*sc_formatters]
    Coveralls.wear!('rails') if uses_cova
  end
  if uses_cc
    # CodeClimate.TestReporter.start
  end
end

# ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### #
#                   SECTION 3 OF 6: Explicit Rails support.                    #
#
# Load the Rails environment, then various Rails test-support files.
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'

require 'minitest/rails/capybara'
require 'capybara/poltergeist'

# ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### #
#                SECTION 4 of 6: Unconditional MiniTest setup.                 #
#
require 'minitest/autorun' # harmless if already required
require 'minitest/reporters'
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(
  color: true, detailed_skip: true, fast_fail: true
)]

require 'minitest/tagz'
tags = ENV['TAGS'].split(',') if ENV['TAGS']
tags ||= []
tags << 'focus'
Minitest::Tagz.choose_tags(*tags, run_all_if_no_match: true)

# Included in generated `test_helper.rb` by Rails' app generator.
# # Base class for all test cases
# class ActiveSupport::TestCase
#   # Add more helper methods to be used by all tests here...
# end

# ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### #
#             SECTION 5 OF 6: Rails/Capybara JavaScript support.               #
#
Capybara.javascript_driver = :poltergeist

# ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### ###### #
#                   SECTION 6 OF 6: Database-support setup.                    #
#
require 'database_cleaner'

DatabaseCleaner.strategy = :transaction

# Opening MiniTest::Spec to add DatabaseCleaner support
class Minitest::Spec
  before :each do
    DatabaseCleaner.start
  end

  after :each do
    DatabaseCleaner.clean
  end
end
