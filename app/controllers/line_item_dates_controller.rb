class LineItemDateController < ApplicationController
  before_action :set_quote

  def new
    @line_item_date = @quote.line_item_dates.build
  end

  def create
    @line_item_date = @quote.line_item_dates.build(line_item_date_params)

    if @line_item_date.save
      redirect_to quote_path(@quote), notice: "Data was created"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def line_item_date_params
    @quote = current_company.quotes.find(params[:quote_id])
  end
end
