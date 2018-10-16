require 'rspec'
require 'rspec/core'
require 'rspec/expectations'
require 'capybara/rspec'
require 'selenium-webdriver'
require 'site_prism'
require 'money'
require 'csv'
require 'spec_helper'

Money.locale_backend = :i18n
I18n.enforce_available_locales = false

$total = nil
# importa todas as classes do framework
Dir[__dir__ + "../../features/pages/*.*"].each {|file| require file}
Dir[__dir__ + "../../features/framework/*.*"].each {|file| require file}

extend RSpec::Matchers

# ENVIRONMENT_TYPE = ENV['ENVIRONMENT_TYPE']
p HEADLESS = "no_headless"

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Capybara::RSpecMatchers
end

Capybara.configure do |config|
  config.default_driver = :selenium
  config.app_host = 'http://automationpractice.com'
  config.default_max_wait_time = 30
end

SitePrism.configure do |config|
  config.use_implicit_waits = true
end