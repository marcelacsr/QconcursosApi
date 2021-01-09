class CreateQuestionAccesses < ActiveRecord::Migration[6.0]
  def change
    create_table :question_accesses do |t|
      t.references :question, foreign_key: true, index: true, null: false
      t.datetime :date
      t.integer :times_accessed
      t.timestamps
    end
  end
end
