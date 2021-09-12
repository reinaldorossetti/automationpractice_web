require_relative 'elements/sign_in_elements'

class SignIn < SignInElements

  # Estou chamado o Modulo Helper pra funções Genericas não se repetir.
  include Helper

  # inicializa os dados via instancia, o que vamos precisar.
  def initialize
    @arr_of_arrs = CSV.read(__dir__ + "/../../data/data.csv")
    @endereco = @arr_of_arrs[0][6]
    @state = @arr_of_arrs[0][8]
    @city = @arr_of_arrs[0][7]
    @zip = @arr_of_arrs[0][9]
    @email = @arr_of_arrs[0][0]
    @pass = @arr_of_arrs[0][1]
    @country = @arr_of_arrs[0][10]
    @data_nasc = @arr_of_arrs[0][4].split("/")
    @fist_name = @arr_of_arrs[0][2]
    @last_name = @arr_of_arrs[0][3]
    @mobile_number = @arr_of_arrs[0][11]
    @company = @arr_of_arrs[0][5]
    @alias = @arr_of_arrs[0][12]
  end

  # caso esteja cadastrado o email, simplimente loga.
  def sign_in
    email_create_elem.send_keys @email
    create_bt_elem.click
    if page.has_text?('registered', :wait => 5)
      login
    else
      register
    end
  end

  # realiza o cadastro do usuario
  def register
    personal_information
    your_address
  end

  def login
    email_elem.set @email
    password_elem.set @pass
    sign_in_elem.click
  end

  def your_address
    y_fist_name_elem.set @fist_name
    y_last_name_elem.set @last_name
    y_company_elem.set @company
    y_city_elem.set @city
    y_address1_elem.set @endereco
    select_custom(@@select_state, @state)
    y_zip_elem.set @zip
    select_custom(@@select_country, @country)
    y_phone_mobile_elem.set @mobile_number
    y_alias_elem.set @alias
    y_submit_bt.click
  end

  # os dados do array vem data.csv
  def personal_information
    # separando a data xx/xx/xx
    dia, mes, ano = @data_nasc
    find(@@gender, visible: false).click
    fist_name_elem.set @fist_name
    last_name_elem.set @last_name
    pass_elem.set @pass
    # converte pra inteiro pra remover o zero da frente do numero.
    select_custom(@@select_dia, dia.to_i)
    select_value(@@select_mes, mes.to_i)
    select_custom(@@select_ano, ano)
  end

  # como estou checando varios valores prefiro fazer dessa forma.
  def check_values_proceed
    [@endereco, @state, @city, @zip].each {|text|
      unless address_delivery_elem.has_text?(text, wait: 5)
        raise "Dados do End: #{text} está Cadastrado Errado!"
      end
    }
    proceed_elem.click
  end

end
