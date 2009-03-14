module RamonTayag
  module Allow
    module SubscriptionsHelper
			def link_to_subscription(object, options={})
				options[:logged_out_text] ||= ""
				if logged_in?
					if object.subscribed_by?(current_user)
						link_to_unsubscribe(object, options.marge!(:unsubscribe_text => options[:unsubscribe_text]))
					else
						link_to_subscribe(object, options.marge!(:subscribe_text => options[:subscribe_text]))
					end
				else
					options[:logged_out_text]
				end
			end
			
      def link_to_subscribe(object, options = {})
				options[:text] ||= "Subscribe"
        options.merge!({:subscribable_id => object.id, :subscribable_type => object.type})
        link_to(options[:text], subscriptions_path(options), :method => :post)
      end

      def link_to_unsubscribe(object, options = {})
				options[:text] ||= "Unsubscribe"
        options.merge!({:subscribable_id => object.id, :subscribable_type => object.type})
        link_to(options[:text], subscriptions_path(options), :method => :destroy)
      end
    end
  end
end
