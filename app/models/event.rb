# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  name       :text
#  day        :integer
#  month      :integer
#  year       :integer
#  level      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Event < ActiveRecord::Base

	has_many :matches, dependent: :destroy
	has_many :participations, dependent: :destroy
	has_many :teams, :through=>:participations

	validates :day, presence:true
	validates :month, presence:true
	validates :year, presence:true, :numericality => {:greater_than => 0}
	validates :name, presence:true, uniqueness:true
	validates :level, presence:true
end
