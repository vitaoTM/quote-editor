# spec/models/quote_spec.rb
require 'rails_helper'

RSpec.describe Quote, type: :model do
  let!(:kpmg) do
  end
  let(:accountant) do
    Company.create!(name: "kpmg").users.create!(
      email: 'accountant_test@kpmg.com', password: "password"
    )
  end

  before do
    def sign_in(user)
      post 'users/sign_in', params: { user: { eamil: user.email, password: user.password } }
    end
    sign_in accountant
  end

  let!(:first_quote) { Quote.create!(name: "First quote") }

  describe 'Creatin a new quote' do
    before do
      visit quotes_path
    end
    it 'display the new quote' do
      click_link first_quote.name
      expect(page).to have_selector "h1", text: "Quotes"
    end
  end

  # describe 'creating a new quote' do
  #   before do
  #     visit quotes_path
  #     expect(page).to have_selector 'h1', text: 'Quotes'

  #     click_on 'New quote'
  #     fill_in 'Name', with: 'Capybara quote'

  #     expect(page).to have_selector 'h1', text: 'Quotes'
  #     click_on 'Create quote'
  #   end

  #   it 'displays the new quote' do
  #     expect(page).to have_selector 'h1', text: 'Quotes'
  #     expect(page).to have_text 'Capybara quote'
  #   end
  # end

  # describe 'updating a quote' do
  #   let(:quote) { quotes(:first) }

  #   before do
  #     visit quotes_path
  #     expect(page).to have_selector 'h1', text: 'Quotes'

  #     click_on 'Edit', match: :first
  #     fill_in 'Name', with: 'Updated quote'

  #     expect(page).to have_selector 'h1', text: 'Quotes'
  #     click_on 'Update quote'
  #   end

  #   it 'displays the updated quote' do
  #     expect(page).to have_selector 'h1', text: 'Quotes'
  #     expect(page).to have_text 'Updated quote'
  #   end
  # end

  # describe 'destroying a quote' do
  #   let(:quote) { quotes(:first) }

  #   before do
  #     visit quotes_path
  #     expect(page).to have_text quote.name

  #     click_on 'Delete', match: :first
  #   end

  #   it 'removes the quote' do
  #     expect(page).not_to have_text quote.name
  #   end
  # end
end
