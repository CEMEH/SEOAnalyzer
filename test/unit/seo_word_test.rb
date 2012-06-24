require "test/unit"
require 'lib/Seo'

class SeoWordTest < Test::Unit::TestCase

  def test_avg_pos
    words = Array[
        'автомашины',
        'word2',
        'word3',
        'автомашины',
        'автомашина',
        'word4',
        'word2'
    ]

    page = Seo::Page.new(words)
    wordAuto = page.words['автомашина']
    assert_equal 3, wordAuto.avg_pos
  end
end