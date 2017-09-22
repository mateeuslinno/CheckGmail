# encoding: UTF-8
require 'net/http'
require 'open-uri'
require 'json'
begin

class String
def black;          "\e[30m#{self}\e[0m" end
def red;            "\e[31m#{self}\e[0m" end
def green;          "\e[32m#{self}\e[0m" end

end
dork = ARGV[0]
limit = ARGV[1]
if limit.nil? || dork != "--limit" 
	puts "Null\n".red
	puts "Usage: --limit 10".red
else
 url_generetor =  open("https://randomuser.me/api/?nat=us&results=#{limit}").read	
 json_parse =JSON.parse(url_generetor)
 json_parse['results'].each do |parsing|
 	first = parsing['name']['first']
 	last  = parsing['name']['last']

 		complet = "#{first}.#{last}"

	uri = URI("https://mail.google.com/mail/gxlu?email=#{complet}@gmail.com")
	res = Net::HTTP.get_response(uri)
	if res['Set-cookie']
		puts "E-mail válido".green
		puts "#{complet}@gmail.com"
		puts "\n"
	else
		puts "E-mail inválido".red
		puts "#{complet}@gmail.com"
		puts "\n"
	end
	
 end
 end
rescue Interrupt => e
puts "[+]Cancelado".red
end
