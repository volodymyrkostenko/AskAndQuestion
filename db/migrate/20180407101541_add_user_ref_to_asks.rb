class AddUserRefToAsks < ActiveRecord::Migration[5.1]
  def change
    add_reference :asks, :user, foreign_key: true
  end
end
