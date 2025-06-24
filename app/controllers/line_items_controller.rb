class LineItemsController < ApplicationController
  before_action :set_quote
  before_action :set_line_item_date

  def new
    @line_item = @line_item_date.line_item.build
  end

  def create
    @line_item = @line_item_date.build(line_item_params)

    if @line_item.save
      redirect_to quote_path(@quote), notice: "Item was created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_quote
    @quote = current_company.quotes.find(params[:quote_id])
  end

  def set_line_item_date
    @line_item_date = @quote.line_item_dates.find(params[:line_item_date_id])
  end
end
