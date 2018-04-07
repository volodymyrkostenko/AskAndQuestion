class CreateAsks < ActiveRecord::Migration[5.1]
  def change
    create_table :asks do |t|
      t.text :question

      t.timestamps
    end
  end
end
