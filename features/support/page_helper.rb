Dir[File.join(File.dirname(__FILE__),
    '../pages/*.rb')].each { |file| require file }

# Modulos para chamar as classes instanciadas
module Pages
end
