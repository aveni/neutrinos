class AddQpToParticipations < ActiveRecord::Migration
  def change
    add_column :participations, :qp, :integer
    add_column :participations, :numMatches, :integer
  end
end
