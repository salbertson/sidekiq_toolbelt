# Sidekiq Toolbelt - Just a test

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sidekiq_toolbelt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sidekiq_toolbelt

## Usage

This library is meant to be used along with `Sidekiq`, probably from a Rails console.

Print job counts:

```
SidekiqToolbelt.counts
# or
SidekiqToolbelt.counts(queue: :important)
```

Kill a job by class:

```
SidekiqToolbelt.kill('User::SignupEmail')
# or
SidekiqToolbelt.kill('User::SignupEmail', queue: :important)
```

Kill a job by error:

```
SidekiqToolbelt.kill('Net::HTTPForbidden')
# or
SidekiqToolbelt.kill('Net::HTTPForbidden', queue: :important)
```

Kill a rescheduled job by class:

```
SidekiqToolbelt.kill_retries('User::SignupEmail')
```

Kill a rescheduled job by error:

```
SidekiqToolbelt.kill_retries_by_error('Net::HTTPForbidden')
```

Continuously kill jobs to keep a queue clear:

```
SidekiqToolbelt.clear('User::SignupEmail')
# or
SidekiqToolbelt.clear('User::SignupEmail', 'User::SubscriptionJob', queue: :important)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/salbertson/sidekiq_toolbelt.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

