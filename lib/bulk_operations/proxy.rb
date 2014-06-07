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
      result = Hash.new
      threads = []

      @operation_stack.size

      @operation_stack.each do |operation|
        name, *args, block = *operation
        threads << spawn_thread(name, args, block, result)
      end

      threads.each { |thread| thread.join }

      StructResult.new result
    end

    def spawn_thread(name, args, block, result)
      thread = Thread.new do
        begin
          call_result = @proxied_object.send(name, *args)
          result[name] = { ok: true, result: call_result }
        rescue => exception
          result[name] = { ok: false, result: exception }
        end
      end

      thread
    end

  end

end









