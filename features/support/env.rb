require 'capybara'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'site_prism'
require 'rspec'
require 'rspec/retry'
require 'money'
require 'csv'
require "allure-cucumber"
require 'webdrivers/chromedriver'
require_relative '../framework/helper.rb'
require_relative 'page_helper.rb'


World(Pages)
World(Helper)

Money.locale_backend = :i18n
I18n.enforce_available_locales = false
Webdrivers.install_dir = './webdrivers/install/dir'
Webdrivers::Chromedriver.update

$total = nil # vai armazenar o total do produto no site.
ENVIRONMENT_TYPE = ENV['ENVIRONMENT_TYPE']
HEADLESS = ENV['HEADLESS']
CONFIG = YAML.load_file(File.dirname(__FILE__) + "/config/#{ENVIRONMENT_TYPE}.yml")

## register driver according with browser chosen
Capybara.register_driver :selenium do |app|
  case HEADLESS
  when 'headless'
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(loggingPrefs: {browser: 'ALL'})
    option = ::Selenium::WebDriver::Chrome::Options.new(args: ['--headless', '--disable-gpu', '--start-maximized'])
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: option, desired_capabilities: caps)
  when 'no_headless'
    caps = Selenium::WebDriver::Remote::Capabilities.chrome(loggingPrefs: {browser: 'ALL'})
    option = ::Selenium::WebDriver::Chrome::Options.new(args: ['--disable-infobars', '--start-maximized'])
    Capybara::Selenium::Driver.new(app, browser: :chrome, options: option, desired_capabilities: caps)
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

# Allure
AllureCucumber.configure do |c|
  c.clean_results_directory = true
  c.link_tms_pattern = 'https://example.org/tms/{}'
  c.link_issue_pattern = 'https://example.org/issue/{}'
  c.tms_prefix = 'TMS_'
  c.issue_prefix = 'ISSUE_'
end