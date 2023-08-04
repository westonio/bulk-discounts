require 'rails_helper'

RSpec.describe 'Merchant Discounts #new Page', type: :feature do
  before :each do
    @merchant1 = Merchant.create!(name: "Hair Care")

    visit new_merchant_discount_path(@merchant1) 
  end

  describe "I am taken to a new page where I see a form to add a new bulk discount" do
    it "has a form to add a new bulk discount" do
      within("#new-discount") do
        expect(page).to have_field("Discount Percent")
        expect(page).to have_field("Quantity Threshold")
        expect(page).to have_button("Add Discount")
      end
    end

    it "redirects to the Merchant Discounts Index and shows new discount" do
      within("#new-discount") do
        fill_in "Discount Percent", with: 25
        fill_in "Quantity Threshold", with: 4
        click_button "Add Discount"
      end

      expect(current_path).to eq(merchant_discounts_path(@merchant1))
  
      expect(page).to have_content("Discount: 25% - Quantity Threshold: 4", count: 1)
      expect(page).to have_content("Discount Successfully Added!")
    end

    it "Shows an error when form not filled out properly" do
      within("#new-discount") do
        click_button "Add Discount"
      end
      expect(page).to have_content("Discount Not Created: Required information missing")
    end
  end
end