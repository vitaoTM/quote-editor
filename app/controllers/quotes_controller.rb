class QuotesController < ApplicationController
  before_action :set_quote, only: [ :show, :edit, :destroy, :update ]

  def index
    @quotes = Quote.all
  end

  def show
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.new(quote_params)
    if @quote.save
      redirect_to quotes_path, notice: "Quote was created"
    else
      render :new
    end
  end

  def update
    if @quote.update(quote_params)
      redirect_to quotes_path, notice: "Quote was updated"
    else
      render :edit
    end
  end

  def destroy
    @quote.destroy
    redirect_to quotes_path, notice: "Quote was deleted"
  end
  private

  def set_quote
    @quote = Quote.find(params[:id])
  end

  def quote_params
    params.require(:quote).permit(:name)
  end
end
