class QuotesController < ApplicationController
  before_action :set_quote, only: [ :show, :edit, :destroy, :update ]

  def index
    @quotes = current_company.quotes.ordered
  end

  def show
    @line_item_dates = @quote.line_item_dates.includes(:line_item).ordered
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = current_company.quotes.build(quote_params)
    #  Quote.new(quote_params)
    if @quote.save
      respond_to do |format|
        format.html {
          redirect_to quotes_path, notice: "Quote was created"
        }
        format.turbo_stream { flash.now[:notice] = "Quote was created" }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @quote.update(quote_params)
      respond_to do |format|
        format.html { redirect_to quotes_path, notice: "Quote was updated" }
        format.turbo_stream { flash.now[:notice] = "Quote was updated" }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @quote.destroy

    respond_to do |format|
      format.html {
        redirect_to quotes_path, notice: "Quote was deleted"
      }
      format.turbo_stream { flash.now[:notice] = "Quote was deleted" }
    end
  end
  private

  def set_quote
    @quote = current_company.quotes.find(params[:id])
    # Quote.find(params[:id])
  end

  def quote_params
    params.require(:quote).permit(:name)
  end
end
