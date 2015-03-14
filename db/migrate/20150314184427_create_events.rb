class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

    	t.text :name
    	t.integer :day
    	t.integer :month
    	t.integer :year
    	t.string :type
      t.timestamps null: false
    end
  end
end
