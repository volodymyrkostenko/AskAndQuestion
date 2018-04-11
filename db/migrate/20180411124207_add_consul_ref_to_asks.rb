class AddConsulRefToAsks < ActiveRecord::Migration[5.1]
  def change
    add_reference :asks, :consultant, foreign_key: true
  end
end
