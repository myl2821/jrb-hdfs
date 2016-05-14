# Jrb::Hdfs

[![Build Status](https://travis-ci.org/myl2821/jrb-hdfs.svg?branch=master)](https://travis-ci.org/myl2821/jrb-hdfs)

Jrb::Hdfs is a self-contained native *HDFS* client which only supports Jruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jrb-hdfs'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jrb-hdfs

## Base Usage

```ruby
require 'jrb/hdfs'

# To create hdfs client, get hadoop config file from your hadoop cluster
client = Jrb::Hdfs::Client.new("hdfs://localhost", "#{ENV['HADOOP_HOME']}/etc/hadoop/")

# list an hdfs entry
client.list('/')

# copy hdfs file to local
client.copy_to_local(src, dst)

# check hdfs file exists
client.exists?(path)

# remove file in hdfs
client.rm(path)

# put file into hdfs
client.put(src, dst)

# mkdir in hdfs
client.mkdir(path) # equals to client.mkdir_p(path)
```
## For Kerberos Authentication

```ruby
client = Jrb::Hdfs::Client.new(
  "hdfs://localhost",
  "ENV['HADOOP_HOME']/etc/hadoop/",
  use_kerberos: true,
  kerberos_username: "no-reply@EXAMPLE.COM",
  kerberos_keytab_path: 'your-kerberos-keytab.keytab')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/myl2821/jrb-hdfs. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

