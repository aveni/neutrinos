class DropTeamsEventsJoinTable < ActiveRecord::Migration
  def change
  	drop_join_table(:events, :teams) do |t|
  	end
  end
end
