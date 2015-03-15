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

	def cleanEvent(event)
		event.teams.each do |t|
			event.teams.delete(t) if event.matches.where('blue1_id=? OR blue2_id=? OR red1_id=? OR red2_id=?', "#{t.id}", "#{t.id}", "#{t.id}", "#{t.id}").size == 0
		end
	end

	def updateEvent(match)
		event = match.event
		event.teams << match.blue1 if event.teams.where(id:match.blue1_id).size == 0
		event.teams << match.blue2 if event.teams.where(id:match.blue2_id).size == 0
		event.teams << match.red1 if event.teams.where(id:match.red1_id).size == 0
		event.teams << match.red2 if event.teams.where(id:match.red2_id).size == 0
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
			if match.red1_id == team.id
				match.red2
			else 
				match.red1
			end
		elsif alliance(match, team) == 1
			if match.blue1_id == team.id
				match.blue2
			else 
				match.blue1
			end
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
