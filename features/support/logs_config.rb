# Configuracao dos arquivos de log gerado.
date_time = DateTime.now
directory_name = "log"
Dir.mkdir(directory_name) unless File.exists?(directory_name)
$logger_name = "Log_file_#{date_time.to_s.gsub(":", "-")}.log"
file = File.open("log/#{$logger_name}", 'w+')
$logger = Logger.new(file)
$logger.level = Logger::ERROR
$logger.datetime_format = '%d-%m-%Y %H:%M:%S'
