class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|

    	t.integer :number
    	t.text :name
      t.timestamps null: false
    end
  end
end
