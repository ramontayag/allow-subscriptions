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

          def self.subscribable?
            true
          end
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

				def subscribe!(user)
					Subscription.create!(:user_id => user.id, :subscribable_type => self.class.name, :subscribable_id => self.id) unless self.subscription_of(user)
				end

				def subscribe(user)
					puts "subscribe(user) will be deprecated soon. User subscribe!(user) instead."
					self.subscribe!(user)
				end
        
        def subscribed_by?(user)
					if user
						return !self.subscription_of(user).nil?
					else
						return false
					end
        end

        #finds the subscription of the given user
        def subscription_of(user)
          self.subscriptions.first(:conditions => {:user_id => user.id})
        end
      end #END: Instance Methods
    end
  end
end
