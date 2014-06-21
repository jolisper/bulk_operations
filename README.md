# BulkOperations

[![Gem Version](https://badge.fury.io/rb/bulk_operations.svg)](http://badge.fury.io/rb/bulk_operations)
[![Build Status](https://travis-ci.org/jolisper/bulk_operations.svg?branch=master)](https://travis-ci.org/jolisper/bulk_operations)

Run your objects methods in a multi-threaded and bulked way.

## Motivation
You want to define different operations in a single object and you want to run them as a bulk and in a unordered (asynchronous) way. Also, you want to run them as a sequence, in the same order you called them.

## Installation

Add this line to your application's Gemfile:

    gem 'bulk_operations'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bulk_operations

## Usage

First define the class of your object:
```ruby
class MyObject
  def operation_1
    # operation_1 code goes here
  end

  def operation_2
    # operation_2 code goes here
  end	
end	
```

Then wrap your object in a bulk:

```ruby
require 'bulk_operations'

bulk = BulkOperations.unordered_bulk( MyObject.new )
```

Call your methods object through the bulk:

```ruby
bulk.operation_1
bulk.operation_2
```

The methods doesn't run immediately, you need to execute the bulk to run them:
```ruby
operations = bulk.execute
```

Through the `operations` object you can ask if a particular operation finished OK, and get the result of this operation:

```ruby
operations.operation_1.ok #=> returns true or false
operations.operation_1.result  #=> returns the result or the raised exception
```

## Considerations about shared mutable state

Bulks doesn't care about the shared mutable state between your operations (at least in this version). So, if your operations share mutable state and you are using an unordered bulk, please add the necessary locks. 

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

