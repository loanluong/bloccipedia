class ChargesController < ApplicationController
  def new
    # Amount in cents
    @amount = 1500
    
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "BigMoney Membership - #{current_user.name}",
      amount: @amount
    }
  end
  
  def create
    @amount = 1500
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
      
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "BigMoney Membership - #{current_user.email}",
      currency: 'usd'
    )
      upgrade_current_user
    
    flash[:notice] = "Thanks for all the money, #{current_user.email}!  Feel free to pay me again."
    redirect_to wikis_path
    
    #rescue block catches and displays errors with a friendly message.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end
  
  def downgrade
    downgrade_current_user
    redirect_to wikis_path
  end
    
end
