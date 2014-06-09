module BulkOperations
  class UnorderedBulkProxy < BulkProxy
    def do_execute
      result = Hash.new
      threads = []

      @operation_stack.size

      @operation_stack.each do |operation|
        name, *args, block = *operation
        threads << spawn_thread(name, args, block, result)
      end

      threads.each(&:join)

      StructResult.new result
    end

    def spawn_thread(name, args, block, result)
      thread = Thread.new do
        begin
          call_result = @proxied_object.send(name, *args, &block)
          result[name] = { ok: true, result: call_result }
        rescue => exception
          result[name] = { ok: false, result: exception }
        end
      end

      thread
    end

  end
end
