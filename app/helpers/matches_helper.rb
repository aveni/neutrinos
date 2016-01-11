module MatchesHelper

	def getMatches(team)
		Match.where('event_id>? AND (blue1_id=? OR blue2_id=? OR red1_id=? OR red2_id=?)', 12, "#{team.id}", "#{team.id}", "#{team.id}", "#{team.id}")
	end
	
	def getEventMatches(team, event)
		Match.where('event_id = ? AND (blue1_id=? OR blue2_id=? OR red1_id=? OR red2_id=?)', "#{event.id}", "#{team.id}", "#{team.id}", "#{team.id}", "#{team.id}")
	end

	def getPlayedMatches(team)
		Match.where('event_id>? AND (blue_score!=0 AND red_score!=0 AND (blue1_id=? OR blue2_id=? OR red1_id=? OR red2_id=?))', 12, "#{team.id}", "#{team.id}", "#{team.id}", "#{team.id}")
	end

	def getPlayedEventMatches(team, event)
		Match.where('event_id = ? AND blue_score!=0 AND red_score!=0 AND (blue1_id=? OR blue2_id=? OR red1_id=? OR red2_id=?)', "#{event.id}", "#{team.id}", "#{team.id}", "#{team.id}", "#{team.id}")
	end


	def removeTeams(event)
		matches = event.matches
		event.participations.each do |p|
			if matches.where('blue1_id=? OR blue2_id=? OR red1_id=? OR red2_id=?', "#{p.team.id}", "#{p.team.id}", "#{p.team.id}", "#{p.team.id}").size == 0
				team = p.team
				p.destroy
				updateTeam(team)
			end
		end
	end
	

	def updateEvent(event)
		removeTeams(event)
		qp = QP(event)
		op = OPR(event)
		event.participations.each do |p|			
			if !p.destroyed?
				updateParticipation(p)
				p.numMatches = qp[p.team.number][0]
				p.curMatches = qp[p.team.number][2]
				p.qp = qp[p.team.number][1]
				p.opr = op[p.team.number]
				p.save
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
		end
	end

	def isPlayed(match)
		match.red_score != 0 && match.blue_score != 0
	end

	def predict(match)
		if !isPlayed(match)
			or1 = match.red1.participations.where(event_id: match.event.id).first.opr
			or2 = match.red2.participations.where(event_id: match.event.id).first.opr
			ob1 = match.blue1.participations.where(event_id: match.event.id).first.opr
			ob2 = match.blue2.participations.where(event_id: match.event.id).first.opr

			red = (or1 + or2).round(0)
			blue = (ob1 + ob2).round(0)

			if red>blue
				"RED #{red}-#{blue}"
			elsif blue>red
				"BLUE #{red}-#{blue}"
			else
				"TIE #{red}-#{blue}"
			end
		else
			"-----------"
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
