require "test/unit"
require 'lib/Parser'

class ParserTest < Test::Unit::TestCase

  def test_parser
    html = "<body><title>Test</title><script>alert('ok');</script><h1>Header</h1><div>div_content</div></body>"
    result = Parser::parse_html(html)
    expected = Array['Header', 'div_content']
    assert_equal expected, result
  end
end