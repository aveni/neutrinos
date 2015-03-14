class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

    	t.text :name
    	t.integer :day
    	t.integer :month
    	t.integer :year
    	t.string :level
      t.timestamps null: false
    end
  end
end
