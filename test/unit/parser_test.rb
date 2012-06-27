require "test/unit"
require 'lib/Parser'

class ParserTest < Test::Unit::TestCase

  def test_parser1
    html = "<html><body><title>Test</title><script>alert('ok');</script><h1>Header</h1><div>div_content</div></body></html>"
    result = Parser::parse_html(html)
    expected = Array['Header', 'div_content']
    assert_equal expected, result
  end

  def test_parser2
    html = "<h1>Header</h1>text"
    result = Parser::parse_html(html)
    expected = Array['Header', 'text']
    assert_equal expected, result
  end

  def test_parser_with_short_words
    html = "<h1>Header</h1>text a by the"
    result = Parser::parse_html(html)
    expected = Array['Header', 'text', 'the',]
    assert_equal expected, result
  end
end