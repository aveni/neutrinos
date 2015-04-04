module MatchesHelper

	def getMatches(team)
		Match.where('blue1_id=? OR blue2_id=? OR red1_id=? OR red2_id=?', "#{team.id}", "#{team.id}", "#{team.id}", "#{team.id}")
	end
	
	def getEventMatches(team, event)
		Match.where('event_id = ? AND (blue1_id=? OR blue2_id=? OR red1_id=? OR red2_id=?)', "#{event.id}", "#{team.id}", "#{team.id}", "#{team.id}", "#{team.id}")
	end


	def updateEvent(event)
		event.participations.each do |p|
			if getEventMatches(p.team, event).size == 0
				p.destroy
			else
				updateParticipation(p)
			end
		end
	end

	def addToEvent(match)
		event = match.event
		teams = getTeams(match)
		teams.each do |t|
			if !event.teams.include?(t)
				p = Participation.create(event_id: event.id, team_id: t.id)
				p.save
			end
			updateParticipation(event.participations.where(team_id: t.id).first)
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

	def winningAlliance(match)
		if match.red_score > match.blue_score
			-1
		elsif match.red_score < match.blue_score
			1
		else 
			0
		end
	end

	def hasTeam(match, team)
		team.id == match.red1_id || team.id == match.red2_id || team.id == match.blue1_id || team.id == match.blue2_id
	end

	def getTeams(match)
		[match.red1, match.red2, match.blue1, match.blue2]
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
