module MatchesHelper

	def cleanEvent(event)
		event.teams.each do |t|
			event.teams.delete(t) if event.matches.where('blue1_id=? OR blue2_id=? OR red1_id=? OR red2_id=?', "#{t.id}", "#{t.id}", "#{t.id}", "#{t.id}").size == 0
		end
	end

	def updateEvent(match)
		event = match.event
		teams = getTeams(match)
		teams.each do |t|
			event.teams << t unless event.teams.include?(t)
		end
	end

	def searchMatches(matches, search)
  	if search != nil && search != ""
			found = [] 
    	teams = Team.all.where('lower(name) LIKE ? OR number = ?', "%#{search}%".downcase, "#{search}".to_i) 
    	teams.each do |t| 
      	matches.each {|m| found << m if !found.include?(m) && hasTeam(m, t)} 
    	end 
    	found
  	else 
	    matches
	  end
  end 


	def sortMatches(matches)
		matches.sort_by {|m| m.number[0]=~ /\A\d+\z/ ? ['A', Integer(m.number)] : [m.number[0], Integer(m.number[1..-1])] }
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
