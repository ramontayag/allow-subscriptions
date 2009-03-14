class Subscription < ActiveRecord::Base
  belongs_to :user
  
  def self.find_subscriptions_of(user)
    self.all(:conditions => {:user_id => user.id}, :order => "created_at DESC")
  end

  def subscribable
    subscribable_type.constantize.find(subscribable_id)
  end

  def self.find_subscribable(type, id)
    type.constantize.find(id)
  end

  protected

  def validate
    errors.add("User has already subscribed") if subscribable.subscribed_by?(user)
    errors.add("That is not subscribable") if !subscribable.subscribable?
  end
end
