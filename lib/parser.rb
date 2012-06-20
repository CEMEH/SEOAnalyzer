module Parser
  require 'nokogiri'
  require 'open-uri'

  doc = Nokogiri::HTML(open('http://catalog-shopping.ru'))
  doc.xpath("//script").remove
  doc.xpath("//style").remove
  puts doc.text
end