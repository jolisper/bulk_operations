require_relative './spec_helper.rb'
require_relative './proxied_object.rb'

describe BulkOperations::UnorderedBulkProxy do

  describe "#proxied_object" do

    before do
      @bulked = ProxiedObject.new
      @bulk   = BulkOperations.unordered_bulk(@bulked)
    end

    it "returns the proxied object" do
      @bulk.instance_variable_get("@proxied_object").must_equal(@bulked)
    end

    describe "when a method is called on a bulk proxy" do
      it "the method call is added to the stack" do
        @bulk.test_method(:param) { :block }
        call_stack = @bulk.instance_variable_get("@operation_stack")
        call_stack.size.must_equal 1
      end
    end

  end
  
  describe "#execute" do
    describe "when the method stack is empty" do
      let(:bulk) { BulkOperations.unordered_bulk(Object.new) }

      it "raise OperationStackEmptyError" do
        lambda { bulk.execute }.must_raise BulkOperations::OperationStackEmptyError
      end
    end
  end

end
