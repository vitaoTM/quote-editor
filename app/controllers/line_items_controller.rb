class IneItemsController < ApplicationController
  before_action :set_quote
  before_action :set_line_item_date

  def new
    @line_item = @line_item_date.line_items.build
  end

  def create
    @line_item = @line_item_date.line_items.build(line_item_params)

    if @line_item.save
      redirect_to quote_path(@quote), notice: "Item was created"
    else
      render :new, status: :unprecessable_entity
    end
  end

  private

  def set_quote
    @quote = current_company.quotes.find(params[:id])
  end

  def set_line_item_date
    @line_item_date = @quote.line_item_dates.find(params[:line_item_date_id])
  end

  def line_item_params
    params.require(:line_item).permit(:name, :quantity, :unity_price)
  end
end
