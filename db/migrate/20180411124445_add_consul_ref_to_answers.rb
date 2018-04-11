class AddConsulRefToAnswers < ActiveRecord::Migration[5.1]
  def change
    add_reference :answers, :consultant, foreign_key: true
  end
end
