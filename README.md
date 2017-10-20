# Rats

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/rats`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rats'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rats

## Usage

```ruby
# Result

def increment(x)
  if x.is_a?(Fixnum)
    Rats.success(x+1)
  else
    Rats.failure('x should be Fixnum')
  end
end

def divide_by(x, y)
  if y == 0
    Rats.failure("can't divide by zero")
  else
    Rats.success(x/y)
  end
end

result = increment(x).flat_map {|a| divide_by(a, 2) }

if result.success?
  puts "Success: #{result.value}"
else
  puts "Failure: #{result.value}"
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/PavelPenkov/rats.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
