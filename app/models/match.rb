# == Schema Information
#
# Table name: matches
#
#  id         :integer          not null, primary key
#  number     :integer
#  blue1_id   :integer
#  blue2_id   :integer
#  red1_id    :integer
#  red2_id    :integer
#  red_score  :integer
#  blue_score :integer
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Match < ActiveRecord::Base

	belongs_to :blue1, :class_name => "Team"
	belongs_to :blue2, :class_name => "Team"
	belongs_to :red1, :class_name => "Team"
	belongs_to :red2, :class_name => "Team"
	belongs_to :event

	validates :blue1_id, presence:true
	validates :blue2_id, presence:true
	validates :red1_id, presence:true
	validates :red2_id, presence:true
	validates :number, presence:true, uniqueness:true
	validates :red_score, presence:true
	validates :blue_score, presence:true
	validates :event_id, presence:true
	validate :isValid

	def isValid
		if blue1_id == blue2_id
			errors.add(:blue1_id, "Repeated team")
			errors.add(:blue2_id, "Repeated team")
		elsif blue1_id == red1_id
			errors.add(:blue1_id, "Repeated team")
			errors.add(:red1_id, "Repeated team")
		elsif blue1_id == red2_id
			errors.add(:blue1_id, "Repeated team")
			errors.add(:red2_id, "Repeated team")
		elsif blue2_id == red1_id
			errors.add(:blue2_id, "Repeated team")
			errors.add(:red1_id, "Repeated team")
		elsif blue2_id == red2_id
			errors.add(:blue2_id, "Repeated team")
			errors.add(:red2_id, "Repeated team")
		elsif red1_id == red2_id
			errors.add(:red1_id, "Repeated team")
			errors.add(:red2_id, "Repeated team")
		end
	end

end
