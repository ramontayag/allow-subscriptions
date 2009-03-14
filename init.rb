require 'allow_subscriptions'
require 'allow_subscriptions_helper'
ActionView::Base.send(:include, RamonTayag::Allow::SubscriptionsHelper)
ActiveRecord::Base.send(:include, RamonTayag::Allow::Subscriptions)
