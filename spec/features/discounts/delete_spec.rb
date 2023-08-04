require 'rails_helper'

RSpec.describe 'Deleting Merchant Discount', type: :feature do
  describe "When I click 'Delete' next to a Discount" do
    before do
      @merchant1 = Merchant.create!(name: "Hair Care")
      @discount1 = @merchant1.discounts.create!(percent_discount: 10, threshold_quantity: 2)
      @discount2 = @merchant1.discounts.create!(percent_discount: 15, threshold_quantity: 5)
      @discount3 = @merchant1.discounts.create!(percent_discount: 30, threshold_quantity: 10)
      @discount4 = @merchant1.discounts.create!(percent_discount: 50, threshold_quantity: 20)
  
      visit merchant_discounts_path(@merchant1)
    end

    it "Redirects back to the bulk discounts index page and discount is no longer listed" do
      expect(page).to have_css("#discount-#{@discount4.id}")
      expect(page).to have_content("Discount: #{@discount4.percent_discount}")

      within("#discount-list") do
        find("#delete-#{@discount4.id}").click
      end

      expect(current_path).to eq(merchant_discounts_path(@merchant1))
      expect(page).to_not have_css("#discount-#{@discount4.id}")
      expect(page).to_not have_content("Discount: #{@discount4.percent_discount}")
    end
  end
end