class SubscriptionsController < ApplicationController
	# Put your authorization, if needed.
  # before_filter :login_required
  # before_filter :check_admin_role, :only => :index
	before_filter :find_subscribable, :only => [:index, :destroy]

  def index
    @subscriptions = @subscribable.subscriptions
  end

  def create
    @subscription = Subscription.new(:subscribable_type => params[:subscribable_type], :subscribable_id => params[:subscribable_id])
    @subscribable = @subscription.subscribable
    @subscription.user = current_user
    @to = params[:to].try(:blank?)

    respond_to do |f|
      if @subscription.save
        flash[:notice] = "Thank you for subscribing."
      else
        flash[:notice] = "There was an error subscribing.  Please try again."
      end
      f.html {redirect_to @to || @subscribable}
      f.js
    end
  end

	def destroy
		@subscription = current_user.subscriptions.first(:conditions => {:subscribable_type => @subscribable.class.name, :subscribable_id => @subscribable.id})
    @to = params[:to].try(:blank?)

		respond_to do |f|
			if @subscription.destroy
				flash[:notice] = "Successfully unsubscribed."
			else
				flash[:notice] = "There was an error unsubscribing. Please try again."
			end
      f.html {redirect_to @to || @subscribable}
	    f.js
		end
	end

	private

	def find_subscribable
		@subscribable = params[:subscribable_type].constantize.find(params[:subscribable_id])
	end
end
