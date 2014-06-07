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

    describe "when the stack is NOT empty" do
      before do
        @bulk = BulkOperations.unordered_bulk(ProxiedObject.new)
        @bulk.operation_1
      end

      it "returns a hash with the results of operation executions" do
        @bulk.execute.must_be_instance_of BulkOperations::StructResult
      end

      it "the result hash has for the operation has ok: = true" do
        result = @bulk.execute
        result.operation_1.ok.must_equal true
      end

      it "the result hash has for the operation has ok: = true" do
        result = @bulk.execute
        result.operation_1.result.must_equal 2
      end

    end

    describe "when an operation raise an exception" do
      before do
        @bulk = BulkOperations.unordered_bulk(ProxiedObject.new)
        @bulk.raise_exception
      end

      it "the result hash has for the operation has ok: = false" do
        result = @bulk.execute
        result.raise_exception.ok.must_equal false
      end

      it "the result hash has for the exception throwed" do
        result = @bulk.execute
        result.raise_exception.result.must_be_instance_of StandardError
      end

    end

  end

end
