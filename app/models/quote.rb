class Quote < ApplicationRecord
  validates :name, presence: true
  belongs_to :company
  has_many :line_item_dates, dependent: :destroy
  has_many :line_items, through: :line_item_dates

  scope :ordered, -> { order(id: :desc) }
  # after_create_commit -> { broadcast_prepend_later_to "quotes", partial: "quotes/quote", locals: { quote: self }, target: "quotes" }
  # after_update_commit -> { broadcast_replace_later_to "quotes", partial: "quotes/quote", locals: { quote: self }, target: "quotes" }
  # after_destroy_commit -> { broadcast_remove_to "quotes" } # , partial: "quotes/quote", locals: { quote: self }, target: "quotes" }

  broadcasts_to ->(quote) { [ quote.company, "quotes" ] }, insert_by: :prepend

  def total_price
    line_items.sum(&:total_price)
  end
end
