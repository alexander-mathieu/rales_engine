require 'csv'

namespace :import_csv do
  desc "populate Customers table from CSV"
  task customers: :environment do
    CSV.foreach("db/data/customers.csv", :headers => true) do |row|
      Customer.create!(row.to_hash)
    end

    puts "Created #{Customer.count} customers."
  end

  desc "populate Merchants table from CSV"
  task merchants: :environment do
    CSV.foreach("db/data/merchants.csv", :headers => true) do |row|
      Merchant.create!(row.to_hash)
    end

    puts "Created #{Merchant.count} merchants."
  end

  desc "populate Invoices table from CSV"
  task invoices: :environment do
    CSV.foreach("db/data/invoices.csv", :headers => true) do |row|
      Invoice.create!(row.to_hash)
    end

    puts "Created #{Invoice.count} invoices."
  end

  desc "populate Items table from CSV"
  task items: :environment do
    CSV.foreach("db/data/items.csv", :headers => true) do |row|
      Item.create!(row.to_hash)
    end

    puts "Created #{Item.count} items."
  end

  desc "populate InvoiceItems table from CSV"
  task invoice_items: :environment do
    CSV.foreach("db/data/invoice_items.csv", :headers => true) do |row|
      InvoiceItem.create!(row.to_hash)
    end

    puts "Created #{InvoiceItem.count} invoice items."
  end

  desc "populate Transactions table from CSV"
  task transactions: :environment do
    CSV.foreach("db/data/transactions.csv", :headers => true) do |row|
      Transaction.create!(row.to_hash)
    end

    puts "Created #{Transaction.count} transactions."
  end
end
