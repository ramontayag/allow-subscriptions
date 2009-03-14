class SubscriptionsController < ApplicationController
  before_filter :login_required

  def create
    @subscription = Subscription.new(params[:subscription])
    @subscribable = @subscription.subscribable
    @subscription.user = current_user

    respond_to do |f|
      if @subscription.save
        flash[:notice] = "Thank you for subscribing."
      else
        flash[:notice] = "There was an error subscribing.  Please try again."
      end
      f.html {redirect_to @subscribable}
      f.js
    end
  end

	def destroy
		@subscribable = params[:subscribable_type].constantize.find(params[:subscribable_id])
		@subscription = current_user.subscriptions.first(:conditions => {:subscribable_type => @subscribable.type, :subscribable_id => @subscribable.id})

		if @subscription.destroy
			flash[:notice] = "Successfully unsubscribed."
		else
			flash[:notice] = "There was an error unsubscribing. Please try again."
		end
    f.html {redirect_to @subscribable}
    f.js
	end
end
