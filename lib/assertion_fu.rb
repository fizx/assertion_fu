# To gain access to the assertions, include AssertionFu in your testing 
# classes.  I often find it helpful to subclass an AbstractTest class, 
# like so:
#
#     class AbstractTest < Test::Unit::TestCase
#       include AssertionFu
#       
#       def test_assertion_fu_included #:nodoc:
#         assert true
#       end
#     end
#
#     class MyTest < AbstractTest
#       # tests go here ...
#     end
module AssertionFu
  class Error < RuntimeError; end
  
  # The contents of the file at the path should match the regex or
  # include the string
  def assert_file_includes(path, regex_or_string)
    assert_file_exists(path)
    content = File.read(path)
    case regex_or_string
    when Regexp
      assert content =~ regex_or_string, 
                     "#{path} doesn't match #{regex_or_string.inspect}"
    else
      assert content.include?(regex_or_string.to_s), 
                     "#{path} doesn't include #{regex_or_string.inspect}"
    end
  end
  
  def assert_includes(content, regex_or_string)
    case regex_or_string
    when Regexp
      assert content =~ regex_or_string, 
                     "#{content.inspect} doesn't match #{regex_or_string.inspect}"
    else
      assert content.include?(regex_or_string.to_s), 
                     "#{content.inspect} doesn't include #{regex_or_string.inspect}"
    end
  end
  
  def assert_length(expected, array)
    assert_equal expected, array.length, "#{array.inspect} has length of #{array.length}, expected #{expected}"
  end
  
  def assert_file_doesnt_include(path, regex_or_string)
    assert_file_exists(path)
    content = File.read(path)
    case regex_or_string
    when Regexp
      assert !(content =~ regex_or_string), 
                     "#{path} matches #{regex_or_string.inspect}"
    else
      assert !content.include?(regex_or_string.to_s), 
                     "#{path} includes #{regex_or_string.inspect}"
    end
  end

  def assert_doesnt_include(content, regex_or_string)
    case regex_or_string
    when Regexp
      assert !(content =~ regex_or_string), 
                     "#{content.inspect} matches #{regex_or_string.inspect}"
    else
      assert !content.include?(regex_or_string.to_s), 
                     "#{content.inspect} includes #{regex_or_string.inspect}"
    end
  end

  def assert_file_exists(path)
    assert File.exists?(path), "#{path} doesn't exist"
  end
  
  def assert_file_doesnt_exist(path)
    assert !File.exists?(path), "#{path} exists"
  end
  
  # Gives more consistent diffs, and is insensitive to the ordering
  # of attributes, and changes in whitespace
  def assert_xml_equal(a, b)
    look_for "libxml"
    a = xml_node(a)
    b = xml_node(b)
    if a.element? && b.element?
      assert_equal a.name, b.name
      assert_equal a.attributes.to_h, b.attributes.to_h
      a.children.zip(b.children).each do |c, d|
        assert_xml_equal c, d
      end
    else
      assert_equal a.to_s.strip, b.to_s.strip
    end
  end
  
  def assert_xml_not_equal(a, b)
    begin
      assert_xml_equal(a, b)
    rescue Test::Unit::AssertionFailedError
      # ok!
    else
      assert false, "XML was equal (#{a.inspect})"
    end
  end
  
  def assert_same_path(a, b)
    assert_equal File.expand_path(a), File.expand_path(b)
  end
  
private

  def look_for(name) #:nodoc:
    require name
  rescue LoadError
    begin
      require "rubygems"
      require name
    rescue LoadError
      raise AssertionFu::Error.new("This assertion requires #{name} to be available")
    end
  end
  
  def xml_node(obj) #:nodoc:
    case obj
    when LibXML::XML::Node:     obj
    when LibXML::XML::Document: obj.root
    else
      LibXML::XML::Document.string(obj.to_s).root
    end
  end
end