module RamonTayag
  module Allow
    module SubscriptionsHelper
			def link_to_subscription(object, options={})
				options[:logged_out_text] ||= ""
				if logged_in?
					unsubscribe_confirm = options[:unsubscribe_confirm]
					subscribe_confirm = options[:subscribe_confirm]
					unsubscribe_text = options[:unsubscribe_text]
					subscribe_text = options[:subscribe_text]
					options.delete(:logged_out_text)
					options.delete(:unsubscribe_confirm)
					options.delete(:subscribe_confirm)
					options.delete(:unsubscribe_text)
					options.delete(:subscribe_text)
					if object.subscribed_by?(current_user)
						link_to_unsubscribe(object, options.merge!(:text => unsubscribe_text, :confirm => unsubscribe_confirm))
					else
						link_to_subscribe(object, options.merge!(:text => subscribe_text, :confirm => subscribe_confirm))
					end
				else
					options[:logged_out_text]
				end
			end
			
      def link_to_subscribe(object, options = {})
				options[:text] ||= "Subscribe"
				text = options[:text]
				confirm = options[:confirm]
        options.merge!({:subscribable_id => object.id, :subscribable_type => object.class.name})
				options.delete(:text)
				options.delete(:confirm)
        link_to(text, subscriptions_path(options.merge!(:to => options[:to])), :confirm => confirm, :method => :post)
      end

      def link_to_unsubscribe(object, options = {})
				options[:text] ||= "Unsubscribe"
				options[:confirm] ||= "Are you sure?"
				text = options[:text]
				confirm = options[:confirm]
        options.merge!({:subscribable_id => object.id, :subscribable_type => object.class.name})
				options.delete(:text)
				options.delete(:confirm)
        link_to(text, subscription_path(options.merge!(:to => options[:to])), :confirm => confirm, :method => :delete)
      end
    end
  end
end
