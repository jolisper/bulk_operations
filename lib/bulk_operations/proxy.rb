module BulkOperations

  class OperationStackEmptyError < StandardError; end

  class BulkProxy
    attr_reader :proxied_object

    def initialize(object)	
      @proxied_object = object
      @operation_stack = []
    end

    def method_missing(name, *args, &block)
      @operation_stack << [name, *args, block]
    end

    def execute
      raise OperationStackEmptyError if @operation_stack.empty?
      do_execute
    end

  end

  class UnorderedBulkProxy < BulkProxy
    def do_execute
      #puts "fhjdskahfjdsakhfljdsalfhdsjakld"; $stderr.flush
    end
  end

end
