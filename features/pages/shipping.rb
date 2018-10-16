class Shipping < SitePrism::Page

  element :terms_confirm_elem, 'input#cgv', visible: false
  element :proceed_elem, 'button[name="processCarrier"]'

  def confirm
    terms_confirm_elem.click
  end

  def proceed
    proceed_elem.click
  end

end