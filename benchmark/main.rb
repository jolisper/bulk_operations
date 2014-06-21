$:.push File.expand_path("../../lib", __FILE__)

require 'bulk_operations'
require 'benchmark'
require 'yaml'

class MyOperations
  def yaml_to_object(yaml)
    YAML.load(yaml)
  end

  def object_to_yaml(object)
    object.to_yaml
  end

  def yaml_to_object2(yaml)
    YAML.load(yaml)
  end

  def object_to_yaml2(object)
    object.to_yaml
  end

  def yaml_to_object3(yaml)
    YAML.load(yaml)
  end

  def object_to_yaml3(object)
    object.to_yaml
  end

  def yaml_to_object4(yaml)
    YAML.load(yaml)
  end

  def object_to_yaml4(object)
    object.to_yaml
  end

  def yaml_to_object5(yaml)
    YAML.load(yaml)
  end

  def object_to_yaml5(object)
    object.to_yaml
  end

end

class MyObject
  attr_accessor :attr1, :attr2, :attr3
  
  def initialize(attr1=1, attr2=2, attr3=3)
    @attr1 = attr1
    @attr2 = attr2
    @attr3 = attr3
  end
end

## Ordered Bulk
my_object = MyObject.new

ordered_bulk = BulkOperations.ordered_bulk(MyOperations.new)

ordered_bulk.yaml_to_object(my_object.to_yaml)
ordered_bulk.object_to_yaml(my_object)
ordered_bulk.yaml_to_object2(my_object.to_yaml)
ordered_bulk.object_to_yaml2(my_object)
ordered_bulk.yaml_to_object3(my_object.to_yaml)
ordered_bulk.object_to_yaml3(my_object)
ordered_bulk.yaml_to_object4(my_object.to_yaml)
ordered_bulk.object_to_yaml4(my_object)
<<<<<<< HEAD
ordered_bulk.yaml_to_object5(my_object.to_yaml)
ordered_bulk.object_to_yaml5(my_object)
=======

>>>>>>> e1a9fa8f0b1eeb6854d4b5495501762e771c1351

## Unordered Bulk
my_object = MyObject.new

unordered_bulk = BulkOperations.unordered_bulk(MyOperations.new)

unordered_bulk.yaml_to_object(my_object.to_yaml)
unordered_bulk.object_to_yaml(my_object)
unordered_bulk.yaml_to_object2(my_object.to_yaml)
unordered_bulk.object_to_yaml2(my_object)
unordered_bulk.yaml_to_object3(my_object.to_yaml)
unordered_bulk.object_to_yaml3(my_object)
unordered_bulk.yaml_to_object4(my_object.to_yaml)
unordered_bulk.object_to_yaml4(my_object)
<<<<<<< HEAD
ordered_bulk.yaml_to_object5(my_object.to_yaml)
ordered_bulk.object_to_yaml5(my_object)

bench_mark = Proc.new do |cant_objects|
  puts "----------------------------------------"
  puts "Marshall/Unmarshall #{cant_objects} objects\n\n"

  Benchmark.bm(15) do |b|
    b.report("Ordered Bulk") do
      cant_objects.times { ordered_bulk.execute } 
    end
    
    b.report("Unordered Bulk") do
      cant_objects.times { unordered_bulk.execute } 
    end
  end

  puts "----------------------------------------\n"
end

# Rehersal
bench_mark.call 1_000


## Benchmarks
5.times do |i|
  bench_mark.call 1_000 * (i + 1)  
end

=======

## Benchmarks
n = 5_000

Benchmark.bmbm(15) do |b|
  b.report("Ordered Bulk") do
    n.times { ordered_bulk.execute } 
  end
  
  b.report("Unordered Bulk") do
    n.times { unordered_bulk.execute } 
  end
end
>>>>>>> e1a9fa8f0b1eeb6854d4b5495501762e771c1351

