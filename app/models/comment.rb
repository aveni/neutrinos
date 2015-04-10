# == Schema Information
#
# Table name: comments
#
#  id               :integer          not null, primary key
#  body             :text
#  author           :string
#  commentable_id   :integer
#  commentable_type :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class Comment < ActiveRecord::Base
	belongs_to :commentable, polymorphic: true

	validates :body, presence: true
	validates :author, presence: true
	validates :commentable_type, presence: true
	validates :commentable_id, presence: true
end
