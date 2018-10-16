class Category < SitePrism::Page

  element :menu_tshirts_elem, '#block_top_menu a[title="T-shirts"][href*="category"]'
  element :menu_dress_elem, '#block_top_menu a[title="Dresses"][href*="category"]'
  element :menu_women_elem, '#block_top_menu a[title="Women"][href*="category"]'
  element :catalog_elem, '#layered_block_left p[class="title_block"]'
  elements :products_elems, 'a[class="product-name"]'
  element :submit_bt_elem, 'button[type="submit"] spanxx'

  def menu(menu_string)
    case menu_string
    when 'T-shirts' then
      menu_tshirts_elem.click
    when 'Women' then
      menu_women_elem.click
    when 'Dresses' then
      menu_dress_elem.click
    else
      raise "Menu Passado Não foi Mapeado!"
    end
  end

  def add_cart
    submit_bt_elem.hover
    submit_bt_elem.click
  end

  def product(name)
    products_elems.each {|prod|
      if prod.text == name
        p name
        prod.send_keys :enter
      end
    }
  end

end