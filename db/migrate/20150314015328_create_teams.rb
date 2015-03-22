class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|

    	t.integer :number
    	t.string :name

    	t.integer :high_score
    	t.float :avg_score
    	t.float :win_perc
    	t.float :avg_cont
    	t.float :st_dev
      t.timestamps null: false
    end
  end
end
