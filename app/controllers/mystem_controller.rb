require 'Mystem'

class MystemController < ApplicationController
  def index

    require 'nokogiri'
    require 'open-uri'

# Get a Nokogiri::HTML:Document for the page we’re interested in...

    doc = Nokogiri::HTML(open('http://catalog-shopping.ru'))
    doc.xpath("//script").remove
    doc.xpath("//style").remove
    @test = doc.text
  end
end
