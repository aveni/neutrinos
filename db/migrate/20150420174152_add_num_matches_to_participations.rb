class AddNumMatchesToParticipations < ActiveRecord::Migration
  def change
  	add_column :participations, :curMatches, :integer
  end
end
