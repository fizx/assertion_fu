# To gain access to the assertions, you can let your tests extend 
# AssertionFu::AbstractTest, or you can include AssertionFu in your testing 
# class.
module AssertionFu
  
  # To gain access to the assertions, you can let your tests extend 
  # AssertionFu::AbstractTest, or you can include AssertionFu in your testing 
  # class.
  class AbstractTest < Test::Unit::TestCase
    include AssertionFu
    
    def test_assertion_fu_included
      assert true
    end
  end
  
  
end