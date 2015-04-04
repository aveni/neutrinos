class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
    	t.references :team
    	t.references :event

    	t.integer :high_score
    	t.float :avg_score
    	t.float :win_perc
    	t.float :avg_cont
    	t.float :st_dev
      t.timestamps null: false
    end
  end
end
