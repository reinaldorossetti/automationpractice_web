
class Payment < SitePrism::Page

  element :total_elem, '#total_price_container #total_price'
  element :payment_bank_wire_elem, '#HOOK_PAYMENT a[class="bankwire"][href*="module=bankwire"]'
  element :payment_check_elem, '#HOOK_PAYMENT a[class="bankwire"][href*="module=cheque"]'
  element :confirm_elem, 'form[action*="validation"] button[type="submit"]'
  element :complete, '#order-confirmation #columns'

  def total_test(format_string = "USD")
    @total = total_elem.text.gsub(/\D/, '').to_i
    return Money.new(@total, format_string).format
  end

  def type_payment(type_string)
    case type_string
    when 'Pay by bank wire' then payment_bank_wire
    when 'Pay by check' then payment_check
    end
  end

  def payment_bank_wire
    payment_bank_wire_elem.click
  end

  def payment_check
    payment_check_elem.click
  end

  def confirm
    confirm_elem.click
  end

end