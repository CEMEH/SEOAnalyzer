require 'lib/Mystem'

module Seo

  WEIGHT_MARK = 0.01
  POSITION_MARK = 0.01

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
    WEIGHT_SPAM = 7

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

    def mark
      self.mark_weight + self.mark_pos
    end

    def avg_pos
      sum_pos = 0
      @words.each_key { |position|
        sum_pos = sum_pos + position
      }
      avg_pos = sum_pos / @words.size
      return avg_pos
    end

    def mark_pos
      avg_pos = self.avg_pos

      1 - avg_pos * Seo::POSITION_MARK
    end

    def weight
      result = (self.count.to_f / @page.count_words.to_f) * 100.0
      return result
    end

    def mark_weight
      weight = self.weight

      # cчитаем что после вес больше WEIGHT_SPAM идет на во вред
      if weight >= WEIGHT_SPAM
        mark = -1 * (weight * Seo::WEIGHT_MARK)
      else
        mark = weight * Seo::WEIGHT_MARK
      end

      mark
    end

  end

end

