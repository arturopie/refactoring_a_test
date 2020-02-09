require "bigdecimal"

RSpec.describe RefactoringATest do
  it "add_item_quantity several quantity v1" do
    # Set  up  fixture
    billing_address = FactoryBot.create(
      :address,
      street: "1222 1st St SW" ,
      city: "Calgary",
      province: "Alberta",
      postal_code: "T2N 2V2",
      country: "Canada"
    )
    shipping_address = FactoryBot.create(
      :address,
      street: "1333 1st St SW",
      city: "Calgary",
      province: "Alberta",
      postal_code: "T2N 2V2",
      country: "Canada"
    )
    customer = FactoryBot.create(
      :customer,
      number: 99,
      name: "John",
      last_name: "Doe",
      percent_discount: BigDecimal("30"),
      billing_address: billing_address,
      shipping_adress: shipping_address
    )
    product = FactoryBot.create(:product, number: 88, code: "SomeWidget", unit_price: BigDecimal("19.99"))
    invoice = FactoryBot.create(:invoice, customer: customer)

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
  end
end
