
# A migration to add tables for Tag and Tagging. This file is automatically generated and added to your app if you run the tagging generator included with has_many_polymorphs.

class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions, :force => true do |t|
      t.string :subscribable_type, :limit => 15, :null => false
      t.integer :subscribable_id, :null => false
      t.integer :user_id, :null => false
      t.column :created_at, :datetime, :null => false
    end
  end
  
  def self.down
    drop_table :subscriptions
  end
end
