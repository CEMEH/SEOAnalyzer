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

      doc.xpath("//*").children.each do |node|
        begin
          node << ' '
        rescue => e
          #todo: убрать этот костыль
        end
      end

      doc.xpath("//script").remove
      doc.xpath("//style").remove
      doc.xpath("//title").remove

      # @todo: тоже костыли
      text = doc.text.gsub(/\s+/, " ").gsub(",", " ").gsub(".", " ").gsub("«", " ").gsub("»", " ").strip
      words = text.split(' ')

      words.delete_if do |word|
        word.strip!
        word.size <= 2
      end

      return words
    end
  end

end
