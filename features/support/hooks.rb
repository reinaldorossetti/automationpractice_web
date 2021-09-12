require_relative '../framework/helper.rb'

Before do |scenario|
  include Capybara::DSL
end

After do |scenario|
  scenario_name = scenario.name.gsub(/[^A-Za-z ]/, '').gsub(/\s+/, '_')

  if scenario.failed?
    img = take_screenshot(file_name: scenario_name.downcase!, test_result: 'failed')
    add_browser_logs
  else
    img = take_screenshot(file_name: scenario_name.downcase!, test_result: 'passed')
  end
  #Allure.add_attachment(name: scenario_name, source: img, type: Allure::ContentType::TXT, test_case: true)
end

