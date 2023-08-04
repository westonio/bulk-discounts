require 'rails_helper'

RSpec.describe 'Merchant Discount Show Page', type: :feature do
  describe 'When I visit my bulk discount show page' do
    before :each do
      @merchant1 = Merchant.create!(name: "Hair Care")
      @discount1 = @merchant1.discounts.create!(percent_discount: 10, threshold_quantity: 2)
      @discount2 = @merchant1.discounts.create!(percent_discount: 15, threshold_quantity: 5)

      visit merchant_discount_path(@merchant1, @discount1)
    end

    it "Shows the bulk discount's quantity threshold and percentage discount" do
      expect(page).to have_content("Discount: #{@discount1.percent_discount}%", count: 1)
      expect(page).to have_content("Quantity Threshold: #{@discount1.threshold_quantity}", count: 1)

      expect(page).to_not have_content(@discount2.percent_discount)
    end

    it "Has a button to edit the discount" do
      expect(page).to have_button("Edit")

      find("#edit-discount-#{@discount1.id}").click

      expect(current_path).to eq(edit_merchant_discount_path(@merchant1, @discount1))
    end
  end
end