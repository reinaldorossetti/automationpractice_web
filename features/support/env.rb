require 'capybara'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'site_prism'
require 'rspec'
require 'rspec/retry'
require 'money'
require 'csv'
require_relative '../framework/helper.rb'
require_relative 'page_helper.rb'

World(Pages)
World(Helper)

Money.locale_backend = :i18n
I18n.enforce_available_locales = false

$total = nil # vai armazenar o total do produto no site.
ENVIRONMENT_TYPE = ENV['ENVIRONMENT_TYPE']
HEADLESS = ENV['HEADLESS']

CONFIG = YAML.load_file(File.dirname(__FILE__) + "/config/#{ENVIRONMENT_TYPE}.yml")

## register driver according with browser chosen
Capybara.register_driver :selenium do |app|
  
  Selenium::WebDriver.logger.level = :error
  Selenium::WebDriver.logger.output = "log/selenium.log"
  
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

SitePrism.configure do |config|
  config.use_implicit_waits = true
end

# tratamento de erro.
RSpec.configure do |config|
  config.verbose_retry = true
  config.default_retry_count = 3
  config.exceptions_to_retry = [Net::ReadTimeout]
end
