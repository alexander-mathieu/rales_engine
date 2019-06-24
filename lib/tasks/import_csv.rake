require 'csv'

namespace :import_csv do
  desc "populate Customers table from CSV"
  task customers: :environment do
    CSV.foreach("db/data/customers.csv", :headers => true) do |row|
      Customers.create!(row.to_hash)
    end
  end

  desc "populate Merchants table from CSV"
  task merchants: :environment do
    CSV.foreach("db/data/merchants.csv", :headers => true) do |row|
      Merchants.create!(row.to_hash)
    end
  end

  desc "populate Invoices table from CSV"
  task invoices: :environment do
    CSV.foreach("db/data/invoices.csv", :headers => true) do |row|
      Invoices.create!(row.to_hash)
    end
  end

  desc "populate Items table from CSV"
  task items: :environment do
    CSV.foreach("db/data/items.csv", :headers => true) do |row|
      Items.create!(row.to_hash)
    end
  end

  desc "populate InvoiceItems table from CSV"
  task invoice_items: :environment do
    CSV.foreach("db/data/invoice_items.csv", :headers => true) do |row|
      InvoiceItems.create!(row.to_hash)
    end
  end

  desc "populate Transactions table from CSV"
  task transactions: :environment do
    CSV.foreach("db/data/transactions.csv", :headers => true) do |row|
      Transactions.create!(row.to_hash)
    end
  end
end
