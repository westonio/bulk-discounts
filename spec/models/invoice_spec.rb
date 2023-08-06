require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "validations" do
    it { should validate_presence_of :status }
    it { should validate_presence_of :customer_id }
  end

  describe "relationships" do
    it { should belong_to :customer }
    it { should have_many(:items).through(:invoice_items) }
    it { should have_many(:merchants).through(:items) }
    it { should have_many :transactions}
    it { should have_many(:discounts).through(:merchants)}
  end

  describe "instance methods" do
    before :each do
      @merchant1 = Merchant.create!(name: 'Hair Care')
      @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id, status: 1)
      @item_2 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 11, merchant_id: @merchant1.id)
      @item_3 = Item.create!(name: "Cat Toy", description: "Has catnip in it", unit_price: 12, merchant_id: @merchant1.id)
      @customer_1 = Customer.create!(first_name: 'Joey', last_name: 'Smith')
      @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
      @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2)
      @ii_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 1, unit_price: 10, status: 1)
      @ii_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_3.id, quantity: 5, unit_price: 10, status: 1)
      @discount_1 = @merchant1.discounts.create!(percent_discount: 20, threshold_quantity: 8)
      @discount_2 = @merchant1.discounts.create!(percent_discount: 10, threshold_quantity: 5)
    end

    it "#total_revenue" do
      expect(@invoice_1.total_revenue).to eq(150)
    end

    describe "Discounts and its Conditions" do
      it "only applies greatest discount when item meets threshold for multiple discounts" do
        @ii_2.destroy
        @ii_3.destroy    
        expect(@invoice_1.invoice_items).to eq([@ii_1])
    
        expect(@invoice_1.total_discount).to eq(18) #invoice item #1 meets boths discount thresholds (5 and 8), so only 20% should be applied
      end
      
      it "only applies the discount to the invoice item(s) that meets the threshold(s)" do
        @ii_3.destroy
        expect(@invoice_1.invoice_items).to eq([@ii_1, @ii_2])

        expect(@invoice_1.total_discount).to eq(18) #invoice item # 2 does not meet any of the discount thresholds
      end

      it "#total_discount" do
        first = @ii_1.quantity * @ii_1.unit_price * (@discount_1.percent_discount / 100.0)
        third = @ii_3.quantity * @ii_3.unit_price * (@discount_2.percent_discount / 100.0)
        expected = first + third

        expect(@invoice_1.total_discount).to eq(expected) #23
      end

      it "#total_discounted_revenue" do
        first = @ii_1.quantity * @ii_1.unit_price * (@discount_1.percent_discount / 100.0)
        third = @ii_3.quantity * @ii_3.unit_price * (@discount_2.percent_discount / 100.0)
        expected = @invoice_1.total_revenue - first - third
        
        expect(@invoice_1.total_discounted_revenue).to eq(expected) #127
      end      
    end
  end
end
