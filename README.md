# GovTech GeekInsider Assessment

The coding assessment as part of GovTech's TAP first stage interview process

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Here are some of the software specifications to this project:

**Ruby**
```
$ ruby -v
ruby 2.3.7p456
```

**MySQL**
*Log into MySQL terminal
```
mysql> SELECT VERSION();
+-----------+
| VERSION() |
+-----------+
| 8.0.15    |
+-----------+
```

### Installing

A step by step series of examples that tell you how to get a development env running

Say what the step will be

```
export POSTGRES_PASSWORD='password'
password: <%= ENV['POSTGRES_PASSWORD'] %>

rake db:create
```

And repeat

```
until finished
```

End with an example of getting some data out of the system or using it for a little demo

## Running the tests

Explain how to run the automated tests for this system

### Break down into end to end tests

Explain what these tests test and why

```
Give an example
```

### And coding style tests

Explain what these tests test and why

```
Give an example
```

## Deployment

Add additional notes about how to deploy this on a live system

## Built With

* [Dropwizard](http://www.dropwizard.io/1.0.2/docs/) - The web framework used
* [Maven](https://maven.apache.org/) - Dependency Management
* [ROME](https://rometools.github.io/rome/) - Used to generate RSS Feeds

## Possible Bugs

```
/Library/Ruby/Gems/2.3.0/gems/bootsnap-1.4.0/lib/bootsnap/load_path_cache/core_ext/kernel_require.rb:21:in `require': dlopen(/Library/Ruby/Gems/2.3.0/gems/mysql2-0.5.2/lib/mysql2/mysql2.bundle, 0x0009): dependent dylib 'libssl.1.0.0.dylib' not found for '/Library/Ruby/Gems/2.3.0/gems/mysql2-0.5.2/lib/mysql2/mysql2.bundle' - /Library/Ruby/Gems/2.3.0/gems/mysql2-0.5.2/lib/mysql2/mysql2.bundle (LoadError)
```

Check out [this stackoverflow page](https://stackoverflow.com/questions/51264240/rake-dbmigrate-error-with-mysql2-gem-library-not-loaded-libssl-1-0-0-dylib)

## Authors

* **Ng Tze Yang**



This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
