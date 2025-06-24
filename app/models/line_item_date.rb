class LineItemDate < ApplicationRecord
  belongs_to :quote
  has_many :line_item, dependent: :destroy

  validates :date, presence: true, uniqueness: { scope: :quote_id }
  scope :ordered, -> { order(date: :asc) }

  def previous_date
    quote.line_item_dates.ordered.where("date < ?", date).last
  end
end
