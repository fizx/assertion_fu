# To gain access to the assertions, you can let your tests extend 
# AssertionFu::AbstractTest, or you can include AssertionFu in your testing 
# class.
module AssertionFu
  
  # To gain access to the assertions, you can let your tests extend 
  # AssertionFu::AbstractTest, or you can include AssertionFu in your testing 
  # class.
  class AbstractTest < Test::Unit::TestCase
    include AssertionFu
    
    
    def test_assertion_fu_included #:nodoc:
      assert true
    end
  end
  
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

  def assert_file_exists(path)
    assert File.exists?(path), "#{path} doesn't exist"
  end
  
  def assert_file_doesnt_exist(path)
    assert !File.exists?(path), "#{path} exists"
  end
  
  
end