require "bigdecimal"

Address = Struct.new(:street, :city, :province, :postal_code, :country)
Customer = Struct.new(:number, :name, :last_name, :percent_discount, :billing_address, :shipping_adress)
Product = Struct.new(:number, :code, :unit_price)

class LineItem
  attr_accessor :invoice, :product, :quantity, :percent_discount

  def initialize(invoice, product, quantity, percent_discount)
    @invoice = invoice
    @product = product
    @quantity = quantity
    @percent_discount = percent_discount
  end

  def unit_price
    product.unit_price
  end

  def extended_price
    (product.unit_price * quantity * (1 - discount)).round(2)
  end

  private

  def discount
    percent_discount / 100
  end
end

class Invoice
  attr_accessor :line_items

  def initialize(customer)
    @customer = customer
    @line_items = []
  end

  def add_item_quantity(product, quantity)
    @line_items << LineItem.new(self, product, quantity, customer.percent_discount)
  end

  private

  attr_accessor :customer
end

RSpec.describe RefactoringATest do
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
