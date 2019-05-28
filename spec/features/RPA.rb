
describe 'Realizar uma compra com sucesso' do

  before :each do
    visit('/')
  end

  it 'Realizar uma compra com sucesso' do

    page_tshirts = Category.new
    page_tshirts.menu('T-shirts') 

    expect(page_tshirts.catalog_elem.text).to eq 'CATALOG'

    page_tshirts.select('In stock')
    page_tshirts.product('Faded Short Sleeve T-shirts')
    page_tshirts.add_cart

    page_order = Order.new
    page_order.order_bt_click
    page_order.validate_name('Faded Short Sleeve T-shirts')
    page_order.data_order_count
    page_order.check_values
    page_order.checkout_bt_click

    page_sign_in = SignIn.new
    page_sign_in.sign_in
    page_sign_in.check_values_proceed

    page_shipping = Shipping.new
    page_shipping.confirm
    page_shipping.proceed

    page_payment = Payment.new
    page_payment.total_test
    page_payment.payment_bank_wire
    page_payment.confirm

    @order = 'Order confirmation'
    @success = 'Your order on My Store is complete.'
    @total = "Amount #{$total}"

    expect(page_payment.complete.text).to have_content @order
    expect(page_payment.complete.text).to have_content @success
    expect(page_payment.complete.text).to have_content @total
  end

end