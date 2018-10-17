# encoding: utf-8
require 'fileutils'

=begin 
  I call Modulo Helper generic functions used in Page to not repeat them.
  Don’t Repeat Yourself (DRY).
  Each function has docstring
=end

module Helper

  # Function to take screenshot and to embed in the html report
  # @param [String] file_name
  # @param [String] test_result
  # @return [void] return void or error message.
  def take_screenshot(file_name:, test_result:)
    file_path = "results/screenshots/test_#{test_result}"
    screenshot = "#{file_path}/#{file_name}.png"
    page.save_screenshot(screenshot)
    embed(screenshot, 'image/png', 'Click here')
  rescue => ex
    p ex
    $logger.error(ex) # armazena o erro em logs.
  end

  # Function Wait for all ajax calls as complete.
  # @return [void] return void.
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop until finished_all_ajax_requests?
    end
  rescue => ex
    p ex
    $logger.error(ex) # armazena o erro em logs.
  end

  # Sub function ajax wait
  # @return [Boolean] return True or False.
  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end

  # Custom Function select box with visible false, for hidden elements.
  # @param [String] locator
  # @param [String] option_value
  # @return [Void] return void or error message.
  def select_custom(locator:, option_value:)
    find(locator, visible: false).first(:option, option_value.to_s, visible: false).select_option
  rescue => ex
    p ex
    $logger.error(ex) # armazena o erro em logs.
    raise "Erro ao Selecionar o combobox com o valor #{option_value} e locator #{locator}."
  end

  # Custom Function select box with parameter value.
  # @param [String] locator
  # @param [String] option_value
  # @return [void] return void or error message.
  def select_value(locator:, option_value:)
    find(locator, visible: false).find("option[value='#{option_value}']").select_option
  rescue => ex
    p ex
    $logger.error(ex) # armazena o erro em logs.
    raise "Erro ao Selecionar o combobox com o valor #{option_value} e locator #{locator}."
  end

end
