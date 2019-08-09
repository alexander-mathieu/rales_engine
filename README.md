![Rales Engine Screenshot](/rales_engine_screenshot.png?raw=true "Rales Engine Screenshot")

# Rales Engine

## About

Welcome to _Rales Engine_! This is a [Turing School of Software & Design](https://turing.io/) project that uses Rails to build a JSON:API exposing the data schema from a retired Turing project, [Sales Engine](https://github.com/turingschool-examples/sales_engine/tree/master/data). Additional information about the project can be found [here](https://backend.turing.io/module3/projects/rails_engine#learning-goals).

## Schema

![Rales Engine Schema](/rales_engine_schema.png?raw=true "Rales Engine Schema")

## Local Installation

### Requirements

* [Ruby 2.4.1](https://www.ruby-lang.org/en/downloads/) - Ruby Version
* [Rails 5.1.7](https://rubyonrails.org/) - Rails Version

### Clone

```
$ git clone https://github.com/alexander-mathieu/rales_engine.git
$ cd rales_engine
$ bundle install
```

### Database Setup

```
$ rake db:{drop,create,migrate}
$ rake import_csv:{customers,merchants,invoices,items,invoice_items,transactions}
```

## API Exploration

Once installation and database setup are complete, explore the various API endpoints with the following steps:

* From the `rales_engine` project directory, boot up a server with `rails s`
* Open your browser, and visit `localhost:3000/`
* In a separate terminal window, query the available endpoints by running `rails routes`
* Copy any of the URIs displayed and append to the `localhost:3000/` in your browser

Example of expected output:
```
{
  "data": {
    "id": "1",
    "type": "merchant",
    "attributes": {
      "name": "Store Name"
    }
  }
}
```

For URIs including an `:id`, please replace `:id` with an integer to observe output.

## Running Tests

Controller and model tests can be run using RSpec:

`$ rspec`

The full testing suite can be run by cloning the spec harness into the parent directory of `rales_engine`:

`$ git clone https://github.com/turingschool/rales_engine_spec_harness.git`

Then:
```
$ cd rales_engine
$ rails s
$ cd ../rales_engine_spec_harness
$ bundle install
$ bundle exec rake
```

Example of expected output:
```
/Users/alexandermathieu/.rbenv/versions/2.4.1/bin/ruby -w -I"lib:test" -I"/Users/alexandermathieu/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/rake-12.3.2/lib" "/Users/alexandermathieu/.rbenv/versions/2.4.1/lib/ruby/gems/2.4.0/gems/rake-12.3.2/lib/rake/rake_test_loader.rb" "test/business_logic/customer_business_logic_test.rb" "test/business_logic/item_business_logic_test.rb" "test/business_logic/merchant_business_logic_test.rb" "test/endpoints/customers_test.rb" "test/endpoints/invoice_items_test.rb" "test/endpoints/invoices_test.rb" "test/endpoints/items_test.rb" "test/endpoints/merchants_test.rb" "test/endpoints/transactions_test.rb" "test/relationships/customer_relationship_test.rb" "test/relationships/invoice_items_relationship_test.rb" "test/relationships/invoices_relationship_test.rb" "test/relationships/items_relationship_test.rb" "test/relationships/merchants_relationship_test.rb" "test/relationships/transactions_relationship_test.rb"
Run options: --seed 17454

# Running:

...........................................................................................................

Fabulous run in 5.996532s, 17.8436 runs/s, 6080.5145 assertions/s.

107 runs, 36462 assertions, 0 failures, 0 errors, 0 skips
```

Additional information on the spec harness can be found [here](https://github.com/turingschool/rales_engine_spec_harness).

## Blog Post

The blog post I wrote while completing this project can be viewed [here](https://medium.com/@alexander_mathieu/from-views-to-apis-with-ruby-on-rails-378ec8c325e5).
