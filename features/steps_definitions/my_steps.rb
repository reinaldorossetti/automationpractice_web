
page_category = Category.new
page_order = Order.new
page_sign_in = SignIn.new
page_shipping = Shipping.new
page_payment = Payment.new

Given(/^que eu esteja no site de compras\.$/) do
  visit "/"
  expect(page.current_url).to eq CONFIG['url_default'] + "/index.php"
  wait_for_ajax
end

When(/^escolher um produto qualquer na loja\.$/) do |table|
  data = table.hashes
  @product_name = data[0][:produto_name]
  @menu = data[0][:menu]
  @filtro = data[0][:filtro]
  page_category.menu(@menu)
  page_category.select(@filtro)
  page_category.product(@product_name)
  page_category.add_cart
end

And(/^prossiga para o checkout\.$/) do
  page_order.order_bt_click
end

Then(/^valide os dados do produto no carrinho\.$/) do
  page_order.validate_name(@product_name)
  page_order.data_order_count
  page_order.check_values
end

When(/^realizar o cadastro do cliente caso não cadastrado, ou realizar o login\.$/) do
  page_order.checkout_bt_click
  page_sign_in.sign_in
end

Then(/^valide se o endereço está correto e prossiga\.$/) do
  page_sign_in.check_values_proceed
end

When(/^aceitar os termos de serviço e prosseguir\.$/) do
  page_shipping.confirm
  page_shipping.proceed
end

Then(/^valide o valor total da compra\.$/) do
  expect(page_payment.total_test).to eq($total)
end

When(/^selecionar um método de pagamento e prosseguir\.$/) do |table|
  data = table.hashes
  page_payment.type_payment(data[0][:tipo_de_pagamento])
  page_payment.confirm
end

Then(/^confirme a compra e valide se foi finalizada com sucesso\.$/) do |table|
  data = table.hashes # => [:mensagens]
  expect(page_payment.complete.text).to have_content data[0][:mensagens]
  expect(page_payment.complete.text).to have_content data[1][:mensagens]
  # variavel $total armazena o total capturado no sistema.
  expect(page_payment.complete.text).to have_content data[2][:mensagens].gsub("XXX", $total)
end