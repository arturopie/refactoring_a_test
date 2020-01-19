require "bigdecimal"

RSpec.describe RefactoringATest do
  it "initialize a line item" do
    billing_address = Address.new("1222 1st St SW", "Calgary", "Alberta", "T2N 2V2","Canada")
    shipping_address = Address.new("1333 1st St SW", "Calgary", "Alberta", "T2N 2V2", "Canada")
    customer = Customer.new(99, "John", "Doe", BigDecimal("30"), billing_address, shipping_address)
    product = Product.new(88, "SomeWidget", BigDecimal("19.99"))
    invoice = Invoice.new(customer)

    item = LineItem.new(invoice, product, 10, 15)

    expect(item.invoice).to eq(invoice)
    expect(item.product).to eq(product)
    expect(item.quantity).to eq(10)
    expect(item.percent_discount).to eq(15)
  end

  it "add_item_quantity several quantity v1" do
    billing_address = nil
    shipping_address = nil
    customer = nil
    product = nil
    invoice = nil

    begin
      # Set  up  fixture
      billing_address = Address.new("1222 1st St SW", "Calgary", "Alberta", "T2N 2V2","Canada")
      shipping_address = Address.new("1333 1st St SW", "Calgary", "Alberta", "T2N 2V2", "Canada")
      customer = Customer.new(99, "John", "Doe", BigDecimal("30"), billing_address, shipping_address)
      product = Product.new(88, "SomeWidget", BigDecimal("19.99"))
      invoice = Invoice.new(customer)

      # Exercise  SUT
      invoice.add_item_quantity(product, 5)

      # Verify  outcome
      line_items = invoice.line_items
      if line_items.size == 1
        item = line_items[0]
        expect(item.invoice).to eq(invoice)
        expect(item.product).to eq(product)
        expect(item.quantity).to eq(5)
        expect(item.percent_discount).to eq(30)
        expect(item.unit_price).to eq(BigDecimal("19.99"))
        expect(item.extended_price).to eq(BigDecimal("69.97"))
      else
        expect(false).to eq(true)
      end
    ensure
      # Teardown
      billing_address = nil
      shipping_address = nil
      customer = nil
      product = nil
      invoice = nil
    end
  end
end
