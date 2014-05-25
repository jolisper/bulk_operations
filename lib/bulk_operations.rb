require "bulk_operations/version"
require "bulk_operations/proxy"

module BulkOperations
  
  def self.unordered_bulk(object)
    UnorderedBulkProxy.new(object)
  end

end
