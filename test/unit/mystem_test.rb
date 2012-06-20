require "test/unit"
require 'lib/Mystem'

class MystemTest < Test::Unit::TestCase

  def test_lemma

    assert_equal "автомашина", Mystem.lemma('автомашина')
    assert_equal "автомашина", Mystem.lemma('автомашины')
    assert_equal "автомашина", Mystem.lemma('Автомашины')
    assert_equal "test??", Mystem.lemma('test')
  end
end