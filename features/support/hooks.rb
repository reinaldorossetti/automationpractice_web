require_relative '../framework/helper.rb'

Before do |scenario|
  include Capybara::DSL
  $logs = page.driver.browser.manage.logs.get(:browser)
end

After do |scenario|
  scenario_name = scenario.name.gsub(/[^A-Za-z ]/, '').gsub(/\s+/, '_')

  if scenario.failed?
    take_screenshot(file_name: scenario_name.downcase!, test_result: 'failed')
    add_browser_logs
  else
    take_screenshot(file_name: scenario_name.downcase!, test_result: 'passed')
  end
  $logger.close
  path = "log/" + $logger_name
  FileUtils.rm_f(path) if File.empty?(path)
end


def add_browser_logs
  # Getting current URL
  current_url = Capybara.current_url.to_s
  # Remove warnings and info messages
  $logs.reject! { |line| ['INFO'].include?(line.first) }
  $logger.error("Current URL: " + current_url.to_s + "\n"  + $logs.to_s) unless $logs.empty?
end
