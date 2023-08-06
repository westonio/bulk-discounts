class InvoiceItem < ApplicationRecord
  validates_presence_of :invoice_id,
                        :item_id,
                        :quantity,
                        :unit_price,
                        :status

  belongs_to :invoice
  belongs_to :item 
  enum status: [:pending, :packaged, :shipped]

  def self.incomplete_invoices
    invoice_ids = InvoiceItem.where("status = 0 OR status = 1").pluck(:invoice_id)
    Invoice.order(created_at: :asc).find(invoice_ids)
  end

  def find_max_percent
    ii = InvoiceItem
      .joins(item: { merchant: :discounts })
      .select("MAX(discounts.percent_discount) as max_percent")
      .where("discounts.threshold_quantity <= invoice_items.quantity")
      .find_by(id: self.id)

    ii.max_percent
  end

  def discount_applied
    item.discounts.find_by(percent_discount: find_max_percent)
  end
end
