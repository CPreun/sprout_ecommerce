require 'stripe'
Stripe.api_key = Rails.application.credentials.stripe[:secret_key]
Stripe.api_version = '2024-04-10'