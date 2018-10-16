
class Order < SitePrism::Page

  element :order_elem, 'a[class*="btn"][href*="controller=order"]'
  elements :product_name_elems, '#order-detail-content p.product-name'
  element :total_products_elem, '#total_product'
  element :total_shipping_elem, '#total_shipping'
  element :total_without_tax_elem, '#total_price_without_tax'
  element :total_tax_elem, '#total_tax'
  element :total_price_elem, '#total_price'
  element :checkout_elem, 'a[href*="step=1"][class*="checkout"] span'

  def initialize
    @total_products = nil
    @total_shipping = nil
    @tax = nil
    @total_without_tax = nil
    @total = nil
  end

  def order_bt_click
    order_elem.click
  end

  def checkout_bt_click
    checkout_elem.click
  end

  # como podemos ter varios produtos, funcao para buscar na tabela.
  def validate_name(string = '')
    located = false
    product_name_elems.each {|product|
      located = true if product.text == string
    }
    raise 'O Produto não foi encontrado no Carrinho!!!' unless located
  end

  # Pega os valores e converte para inteiro.
  def data_order_count
    @total_products = total_products_elem.text.gsub(/\D/, '').to_i
    @total_shipping = total_shipping_elem.text.gsub(/\D/, '').to_i
    @total_without_tax = total_without_tax_elem.text.gsub(/\D/, '').to_i
    @tax = total_tax_elem.text.gsub(/\D/, '').to_i
    @total = total_price_elem.text.gsub(/\D/, '').to_i
  end

  # Usando a lib money para validar os valores, pode passar um formato diferente para outra moeda.
  def check_values(format = 'USD')

    p $total = Money.new(@total, format).format

    unless Money.new(@total_products + @total_shipping, format) == Money.new(@total_without_tax, format)
      raise 'Valor total sem Tax está incorreto!'
    end

    unless Money.new(@total_without_tax + @tax, format) == Money.new(@total, format)
      raise 'Valor total com Tax está incorreto!'
    end
  end

end