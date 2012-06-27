require 'lib/Mystem'

module Seo
  class Page
    def initialize(words)
      @words = Hash.new
      words.each_with_index { |word, position| self::add_word((position.to_i+1), word) }
    end

    def words
      @words
    end

    def add_word(position, word)
      lemma = Mystem.lemma(word)

      if !@words.key?(lemma)
        @words[lemma] = Word.new(lemma)
      end

      @words[lemma].add(word, position)
    end
  end

  class Word

    def initialize(word)
      @word = word
      @words = Hash.new
      @count = 0
    end

    def word
      @word
    end

    def count
      @count
    end

    def add(word, position)
      @count = @count + 1
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

  end


end
