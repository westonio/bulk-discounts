class DiscountsController < ApplicationController
  before_action :find_merchant_and_discount, only: [:show, :edit, :update, :destroy]
  before_action :find_merchant, only: [:index, :new, :create]

  def index
    @holidays = HolidaysService.new.next_three_holidays
  end

  def show

  end
  
  def new
    @discount = Discount.new
  end

  def create
    discount = Discount.new(discount_params)
    if discount.save
      redirect_to merchant_discounts_path(@merchant)
      flash[:success] = "Discount Successfully Added!" 
    else
      flash[:danger] = "Discount Not Created: Required information missing"
      redirect_to new_merchant_discount_path(@merchant)
    end
  end

  def edit

  end

  def update
    if @discount.update(discount_params)
      redirect_to merchant_discount_path(@merchant, @discount)
      flash[:success] = "Discount Successfully Updated!"
    else
      flash[:danger] = "Discount Not Updated: Fields cannot be empty"
      redirect_to edit_merchant_discount_path(@merchant, @discount)
    end
  end

  def destroy
    @discount.destroy
    redirect_to merchant_discounts_path(@merchant)
  end

private

  def discount_params
    params.require(:discount).permit(:percent_discount, :threshold_quantity, :merchant_id)
  end

  def find_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end

  def find_merchant_and_discount
    @merchant = Merchant.find(params[:merchant_id])
    @discount = Discount.find(params[:id])
  end
end