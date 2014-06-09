module BulkOperations
  class OrderedBulkProxy < BulkProxy
    def do_execute
      result = Hash.new
      fibers = []

      @operation_stack.size

      @operation_stack.each do |operation|
        name, *args, block = *operation
        fibers << create_fiber(name, args, block, result)
      end

      fibers.each(&:resume)

      StructResult.new result
    end

    def create_fiber(name, args, block, result)
      fiber = Fiber.new do
        begin
          call_result = @proxied_object.send(name, *args, &block)
          result[name] = { ok: true, result: call_result }
        rescue => exception
          result[name] = { ok: false, result: exception }
        end
      end

      fiber
    end

  end
end
