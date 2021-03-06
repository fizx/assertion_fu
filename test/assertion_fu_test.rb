require "test/unit"
require File.dirname(__FILE__) + "/../lib/assertion_fu"

class AssertionFuTest < Test::Unit::TestCase #:nodoc:
  include AssertionFu
  
  def test_file_exists
    assert_file_exists(__FILE__)
    assert_file_doesnt_exist(__FILE__ + "dfadsfa")
  end
  
  def test_file_includes
    assert_file_includes(__FILE__, "__FILE__")
    assert_file_doesnt_include(__FILE__, "12341234" + "asdeasf")
    assert_file_includes(__FILE__, /__FILE__/)
    assert_file_doesnt_include(__FILE__, /dafaf{999}/)
  end
  
  def test_length
    assert_length 3, %w[a b c]
  end
  
  def test_xml
    assert_xml_equal(%[<a />], %[<a />])
    assert_xml_equal(%[<a  b="c"/>], %[<a b="c"/>])
    assert_xml_equal(%[<a b="c" c="d"/>], %[<a c="d" b="c"/>])
    assert_raises(Test::Unit::AssertionFailedError) do
      assert_xml_not_equal(%[<a b="c" c="d"/>], %[<a c="d" b="c"/>])
    end
    assert_xml_not_equal(%[<a b="c" c="d"/>], %[<z c="d" b="c"/>])
  end
end