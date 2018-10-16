class SignInElements < SitePrism::Page
  # menu inicial
  element :email_create_elem, 'input#email_create'
  element :email_elem, 'input#email'
  element :password_elem, 'input#passwd'
  element :create_bt_elem, 'button#SubmitCreate'
  element :sign_in_elem, 'button#SubmitLogin'

  #formulario personal information
  element :gender_elem, 'input#id_gender1'
  element :fist_name_elem, 'input#customer_firstname'
  element :last_name_elem, 'input#customer_lastname'
  element :pass_elem, 'input#passwd'

  # formulario your address
  element :y_fist_name_elem, 'input#firstname'
  element :y_last_name_elem, 'input#lastname'
  element :y_company_elem, 'input#company'
  element :y_address1_elem, 'input#address1'
  element :y_city_elem, 'input#city'
  element :y_zip_elem, 'input#postcode'
  element :y_phone_mobile_elem, 'input#phone_mobile'
  element :y_alias_elem, 'input#alias'
  element :y_submit_bt, 'button#submitAccount'

  # page confirm
  element :address_delivery_elem, '#address_delivery'
  element :proceed_elem, 'button[name="processAddress"]'

  # elementos visible=false
  @@gender = 'input#id_gender1'
  @@select_dia = 'select#days'
  @@select_mes = 'select#months'
  @@select_ano = 'select#years'
  @@select_state = 'select#id_state'
  @@select_country = 'select#id_country'
end