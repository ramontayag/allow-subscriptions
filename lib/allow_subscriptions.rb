#heavily based on Juixe's acts_as_subscribable
module RamonTayag
  module Allow
    module Subscriptions
      def self.included(base)
        base.extend ClassMethods
      end

      module ClassMethods
        def allow_subscriptions
          has_many :subscriptions, :as => :subscribable, :dependent => :delete_all
          include RamonTayag::Allow::Subscriptions::InstanceMethods
          extend RamonTayag::Allow::Subscriptions::SingletonMethods
        end
      end

      # This module contains class methods
      module SingletonMethods
        def subscriptions_of(user)
          subscribable = ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s
          Subscription.find(:all,
            :conditions => ["user_id = ? and subscribable_type = ?", user.id, subscribable],
            :order => "created_at DESC"
          )
        end
      end
      
      # This module contains instance methods
      module InstanceMethods
        # Same as subscribable.subscriptions.size
        def subscriptions_count
          self.subscriptions.size
        end
        
        def subscribers
          self.subscriptions.collect(&:user)
        end
        
        def subscribed_by?(user)
          if user
            self.subscriptions.each do |v|
              return true if user == v.user
            end
          end
          false
          #true
        end

        #finds the subscription of the given user
        def subscription_of(user)
          self.subscriptions.first(:conditions => {:user_id => user.id})
        end
      end #END: Instance Methods
    end
  end
end
