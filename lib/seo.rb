require 'Mystem'

module Seo
  class Page
    def initialize(words)
      @wordLemms = Mystem.lemma(words)
      @words = Hash.new
      @count_words = words.size
      words.each_with_index { |word, position| self::add_word((position.to_i+1), word) }
    end

    def words
      @words
    end

    def count_words
      @count_words
    end

    def add_word(position, word)
      lemma = @wordLemms[word]

      if !@words.key?(lemma)
        @words[lemma] = Word.new(lemma, self)
      end

      @words[lemma].add(word, position)
    end
  end

  class Word

    def initialize(word, page)
      @word = word
      @words = Hash.new

      if page.instance_of? Page
        @page = page
      else
        raise TypeError, "Argument page is not instance of Page"
      end
    end

    def to_s
      @word
    end

    def count
      return @words.size
    end

    def words
      @words
    end

    def add(word, position)
      @words[position] = word
    end

    def avg_pos
      sum_pos = 0
      @words.each_key { |position|
        sum_pos = sum_pos + position
      }
      avg_pos = sum_pos / @words.size
      return avg_pos
    end

    def weight
      result = (self.count.to_f / @page.count_words.to_f) * 100.0
      return result
    end

  end

end

