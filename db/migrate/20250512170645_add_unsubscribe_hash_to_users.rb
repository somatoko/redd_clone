class AddUnsubscribeHashToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :unsubscribe_hash, :string
    add_column :users, :comment_subscription, :boolean, default: true
  end
end
