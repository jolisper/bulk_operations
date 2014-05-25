require_relative './spec_helper.rb'

describe BulkOperations do

  describe "::unorderedBulk(object)" do
    it "returns a BulkOperations::UnorderedBulkProxy" do
      proxy = BulkOperations.unordered_bulk(Object.new)
      proxy.must_be_instance_of BulkOperations::UnorderedBulkProxy
    end
  end

end
