# Command Client Ruby Library

The Command Client Ruby library provides convenient access to the golf
[Command System](http://www.commandsystem.org/) API from applications written
in the Ruby language. It adheres to the current Command API specs and returns
instances of Ruby classes that can be used to get the latest data from
Command.

## Documentation

See the `docs` folder of this repository for API information.

### Requirements

* Ruby 2.0+.

### Bundler

Add the following to your `Gemfile`:

``` ruby
gem 'command-client', git: "git://github.com/ohiogolf/command-client"
```

## Usage

The library needs to be configured with your Command account's company name,
username and password. If you are using this gem within a Rails application,
this would typically go inside an initializer file.

``` ruby
require 'command-client'
Command::Client.company_name = "mygolfcompany"
Command::Client.user_name = "mygolfcompany.org"
Command::Client.password = "password"

# find golf club
club = Command::Client::Club.find(club_number: 1)
club.club_number # 1
club.club_name # Golf Club of America
club.architect # Jimmy Jones
club.addresses.first.street # 123 Main Street

# search golf clubs
clubs = Command::Client::Club.search(club_name: "Stone")
clubs.size # 2
clubs[0].club_name # Stoney Creek Golf Club
clubs[1].club_name # Stone Throw Country Club
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/command-client.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
