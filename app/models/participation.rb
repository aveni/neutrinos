# == Schema Information
#
# Table name: participations
#
#  id         :integer          not null, primary key
#  team_id    :integer
#  event_id   :integer
#  high_score :integer
#  avg_score  :float
#  win_perc   :float
#  avg_cont   :float
#  st_dev     :float
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Participation < ActiveRecord::Base

	belongs_to :event
	belongs_to :team

	after_destroy :cleanup


	validates :event_id, presence: true
	validates :team_id, presence: true

	def cleanup
		updateTeam(self.team)
	end

end