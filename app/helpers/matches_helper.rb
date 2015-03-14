module MatchesHelper

	def winningAlliance(match)
		if match.red_score > match.blue_score
			-1
		elsif match.red_score < match.blue_score
			1
		else 
			0
		end
	end

	def alliance(match, team)
		if match.red1_id == team.id || match.red2_id == team.id
			-1
		elsif match.blue1_id == team.id || match.blue2_id == team.id
			1
		else
			0
		end
	end

	def partner(match, team)
		if alliance(match, team) == -1
			match.red2 if match.red1_id == team.id
			match.red2 if match.red1_id == team.id
		elsif alliance(match, team) == 1
			match.blue2 if match.blue1_id == team.id
			match.blue1
		end
	end

	def teamWon?(match, team)
		alliance(match, team)!=0 && alliance(match,team) == winningAlliance(match)
	end

	def winningScore(match)
		if match.red_score > match.blue_score
			match.red_score
		else
			match.blue_score
		end
	end

	def teamScore(match, team)
		if alliance(match, team) == -1
			match.red_score
		elsif alliance(match, team) == 1
			match.blue_score
		else
			-1
		end
	end

end
