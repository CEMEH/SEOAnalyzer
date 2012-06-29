require "test/unit"
require 'lib/Seo'

class SeoWordTest < Test::Unit::TestCase

  attr_accessor :page, :testWord, :cntWords

  def setup
    words = Array[
        'автомашины',
        'word2',
        'word3',
        'автомашины',
        'автомашина',
        'word4',
        'word2',
    ]

    @page = Seo::Page.new(words)
    @testWord = 'автомашина'
    @cntWords = words.size
    @wordAuto = page.words[testWord]
  end

  def test_avg_pos
    assert_equal 3, @wordAuto.avg_pos
  end

  def test_word_name
    assert_equal @testWord, @wordAuto.to_s
  end

  def test_word_count
    assert_equal 3, @wordAuto.count
  end

  def test_word_weight
    assert_in_delta 42.857, @wordAuto.weight, 0.001
  end

  def test_words_unq
    assert_equal 4, @page.words.size
  end

  def test_count_words
     assert_equal @cntWords, @page.count_words
  end

  def test_list_words
    expected_words = Array[
        'автомашина',
        'word2',
        'word3',
        'word4',
    ]
    assert_equal expected_words.sort, @page.words.keys.sort
  end
end