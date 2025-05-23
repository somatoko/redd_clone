
class PricingsController < ApplicationController
  def show
    Stripe.api_key = Rails.application.credentials.dig(:stripe, :private_key)
  end
end