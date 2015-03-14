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

require 'test_helper'

class MatchTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
