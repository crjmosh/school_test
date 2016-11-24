class CreateClassrooms < ActiveRecord::Migration[5.0]
  def change
    create_table :classrooms do |t|
      t.string :subject, required: true
      t.integer :students
      t.belongs_to :school, foreign_key: true

      t.timestamps
    end
  end
end
