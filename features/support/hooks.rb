require_relative '../framework/helper.rb'

Before do |scenario|
  include Capybara::DSL
end

After do |scenario|
  scenario_name = scenario.name.gsub(/[^A-Za-z ]/, '').gsub(/\s+/, '_')

  if scenario.failed?
    take_screenshot(file_name: scenario_name.downcase!, test_result: 'failed')
    add_browser_logs
  else
    take_screenshot(file_name: scenario_name.downcase!, test_result: 'passed')
  end
end

