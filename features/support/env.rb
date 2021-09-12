require 'capybara'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'site_prism'
require 'rspec'
require 'rspec/retry'
require 'money'
require 'csv'
require "allure-cucumber"
require_relative '../framework/helper.rb'
require_relative 'page_helper.rb'


World(Pages)
World(Helper)

Money.locale_backend = :i18n
I18n.enforce_available_locales = false

$total = nil # vai armazenar o total do produto no site.
ENVIRONMENT_TYPE = ENV['ENVIRONMENT_TYPE']
HEADLESS = ENV['HEADLESS']

$projectPath = File.dirname(__FILE__).replace("features")[0]
puts $projectPath

CONFIG = YAML.load_file(File.dirname(__FILE__) + "/config/#{ENVIRONMENT_TYPE}.yml")

## register driver according with browser chosen
Capybara.register_driver :selenium do |app|
 
  if HEADLESS.eql?('headless')
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(loggingPrefs: {browser: 'ALL'})
    option = ::Selenium::WebDriver::Chrome::Options.new(args: ['--headless', '--disable-gpu', '--start-maximized'])
    session = Capybara::Selenium::Driver.new(app, browser: :chrome, options: option, desired_capabilities: caps)
  elsif HEADLESS.eql?('no_headless')
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(loggingPrefs: {browser: 'ALL'})
    option = ::Selenium::WebDriver::Chrome::Options.new(args: ['--disable-infobars', '--start-maximized'])
    session = Capybara::Selenium::Driver.new(app, browser: :chrome, options: option, desired_capabilities: caps)
  end
  
end

Capybara.configure do |config|
  config.default_driver = :selenium
  config.app_host = CONFIG['url_default']
  config.default_max_wait_time = 30
end

# tratamento de erro.
RSpec.configure do |config|
  config.verbose_retry = true
  config.default_retry_count = 3
  config.exceptions_to_retry = [Net::ReadTimeout]
end

AllureCucumber.configure do |config|
  config.results_directory = "../../report/allure-results"
  config.clean_results_directory = true
  config.logging_level = Logger::INFO
  config.logger = Logger.new($stdout, Logger::DEBUG)
  config.environment = "staging"

  # these are used for creating links to bugs or test cases where {} is replaced with keys of relevant items
  config.link_tms_pattern = "http://www.jira.com/browse/{}"
  config.link_issue_pattern = "http://www.jira.com/browse/{}"

  # additional metadata
  # environment.properties
  config.environment_properties = {
    custom_attribute: "foo"
  }
  # categories.json
  config.categories = File.new("my_custom_categories.json")
end