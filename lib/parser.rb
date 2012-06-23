require 'rubygems'
require 'nokogiri'
require 'open-uri'

module Parser
  class << self

    def parse_path(path)
      doc = self::doc(path)
      return self::words(doc)
    end

    def parse_html(html)
      doc = Nokogiri::HTML(html)
      return self::words(doc)
    end

    protected

    def doc(path)
      return Nokogiri::HTML(open(path))
    end

    def words(doc)
      doc.xpath("//script").remove
      doc.xpath("//style").remove
      doc.xpath("//title").remove

      #todo: добавить пробел к концу каждого тэга
      doc.search('br').each { |br| br << ' ' }
      doc.search('h1').each { |br| br << ' ' }
      doc.search('div').each { |br| br << ' ' }

      text = doc.text.gsub(/\s+/, " ").strip
      return text.split(' ')
    end
  end

end

