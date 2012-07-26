require "test/unit"
require 'lib/Mystem'

class MystemTest < Test::Unit::TestCase

  def test_lemma
    assert_equal [{"автомашина"=>"автомашина"}], [Mystem.lemma('автомашина')]
    assert_equal [{"автомашины"=>"автомашина"}], [Mystem.lemma('автомашины')]
    assert_equal [{"Автомашины"=>"автомашина"}], [Mystem.lemma('Автомашины')]
    assert_equal [{"test"=>"test??"}], [Mystem.lemma('test')]
  end

  def test_lemma_array
    assert_equal [{"test"=>"test??", "автомашина"=>"автомашина"}], [Mystem.lemma(['автомашина', 'test'])]
    assert_equal [{"автомашин"=>"автомашина", "автомашины"=>"автомашина"}], [Mystem.lemma(['автомашины', 'автомашин'])]
  end

  def test_lemma_wrong
    assert_equal [{"test1"=>"test1"}], [Mystem.lemma(['test1'])]
    assert_equal [{"автомашин"=>"автомашина", "test1"=>"test1"}], [Mystem.lemma(['test1', 'автомашин'])]
  end
end