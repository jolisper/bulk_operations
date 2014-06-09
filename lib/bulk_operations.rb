require "bulk_operations/version"
require "bulk_operations/proxy"
require "bulk_operations/ordered_bulk"
require "bulk_operations/unordered_bulk"
require "bulk_operations/struct_result"

module BulkOperations
  
  def self.unordered_bulk(object)
    UnorderedBulkProxy.new(object)
  end

  def self.ordered_bulk(object)
    OrderedBulkProxy.new(object)
  end

end
