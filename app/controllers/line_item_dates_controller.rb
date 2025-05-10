class LineItemDatesController < ApplicationController
  before_action :set_quote
  before_action :set_line_item_date, only: [ :edit, :update, :destroy ]

  def new
    @line_item_date = @quote.line_item_dates.build
  end

  def create
    @line_item_date = @quote.line_item_dates.build(line_item_date_params)

    if @line_item_date.save
      respond_to do |format|
        format.html { redirect_to quote_path(@quote), notice: "Date was created" }
        format.turbo_stream { flash.now[:notice] = "Data was created" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @line_item_date.update(line_item_date_params)
      respond_to do |format|
        format.html { redirect_to quote_path(@quote), notice: "Date was Updated" }
        format.turbo_stream { flash.now[:notice] = "Date was Updated" }
      end
    else
      render :edit, status: :unprecessable_entity
    end
  end

  def destroy
    @line_item_date.destroy

    respond_to do |format|
      format.html { redirect_to quote_path(@quote), notice: "Date was deleted" }
      format.turbo_stream { flash.now[:notice] = "Date was deleted" }
    end
  end

  private

  def set_line_item_date
    @line_item_date = @quote.line_item_dates.find(params[:id])
  end

  def line_item_date_params
    params.require(:line_item_date).permit(:date)
  end

  def set_quote
    @quote = current_company.quotes.find(params[:quote_id])
  end
end
