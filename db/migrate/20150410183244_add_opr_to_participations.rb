class AddOprToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :opr, :float
  end
end
