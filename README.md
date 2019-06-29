# Rales Engine

## Description
This is a [Turing School of Software and Design](https://turing.io/) project that uses Rails to build a REST API which exposes the [SalesEngine](https://github.com/turingschool-examples/sales_engine/tree/master/data) data schema.

## Requirements
 * [Ruby 2.4.1](https://www.ruby-lang.org/en/downloads/) - Ruby Version
 * [Rails 5.1.7](https://rubyonrails.org/) - Rails Version

## Installation
```
$ git clone https://github.com/alexander-mathieu/rales_engine.git
$ cd rales_engine
$ bundle install
```

## Database Setup
```
$ rake db:{drop,create,migrate}
$ rake import_csv:{customers,merchants,invoices,items,invoice_items,transactions}
```

## Schema

## API Exploration

## Running Tests
Controller and model tests can be run using RSpec:

`$ rspec`

The full testing suite can be run by cloning the spec harness into the PARENT DIRECTORY of `rales_engine`:

`$ git clone https://github.com/turingschool/rales_engine_spec_harness.git`

Then:
```
$ cd rales_engine
$ rails s
$ cd ../rales_engine_spec_harness
$ bundle install
$ bundle exec rake
```

Additional information on the spec harness can be found <a href="https://github.com/turingschool/rales_engine_spec_harness">here</a>.

## Author

Alexander Mathieu
