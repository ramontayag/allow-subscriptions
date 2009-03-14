module RamonTayag
  module Allow
    module SubscriptionsHelper
			def link_to_subscription(object, options={})
				options[:logged_out_text] ||= ""
				if logged_in?
					options.delete(:logged_out_text)
					if object.subscribed_by?(current_user)
						link_to_unsubscribe(object, options.merge!(:text => options[:unsubscribe_text], :confirm => options[:unsubscribe_confirm]))
					else
						link_to_subscribe(object, options.merge!(:text => options[:subscribe_text], :confirm => options[:subscribe_confirm]))
					end
				else
					options[:logged_out_text]
				end
			end
			
      def link_to_subscribe(object, options = {})
				options[:text] ||= "Subscribe"
				text = options[:text]
        options.merge!({:subscribable_id => object.id, :subscribable_type => object.class.name})
				options.delete(:text)
        link_to(text, subscriptions_path(options), :confirm => options[:confirm], :method => :post)
      end

      def link_to_unsubscribe(object, options = {})
				options[:text] ||= "Unsubscribe"
				options[:confirm] ||= "Are you sure?"
				text = options[:text]
        options.merge!({:subscribable_id => object.id, :subscribable_type => object.class.name})
				options.delete(:text)
        link_to(text, subscription_path(options), :confirm => options[:confirm], :method => :delete)
      end
    end
  end
end
