module ApplicationHelper

	def blue(text)
		content_tag(:span, text, class: "label label-primary label-as-badge")
	end

	def red(text)
		content_tag(:span, text, class: "label label-danger label-as-badge")
	end

	def show_role(user)
    if user.is?(:admin)
	    content_tag(:span, 'Admin', class:'label label-warning') 
	  elsif user.is?(:scorer)
		  content_tag(:span, 'Scorer', class:'label label-primary')
		elsif user.is?(:neutrinos)
		  content_tag(:span, 'Neutrinos', class:'label label-success')
		end
	end

	def resetAllParticipations
		Team.all.each do |t|
			matches = getMatches(t)
			matches.each do |m|
				if Participation.where(team_id: t.id, event_id: m.event.id).first == nil
					p = Participation.create(team_id: t.id, event_id: m.event.id)
					p.save
				end
			end
		end
		Participation.all.each {|p| updateParticipation(p)}
	end

	def loadMatches(data, event)
		matches = data.split("\n")

		matches.each do |match|
			truth = match.split(" ")

			m = Match.new
			m.number = truth[0].to_i
			m.red1_id = Team.where(number: truth[1]).first.id
			m.red2_id = Team.where(number: truth[2]).first.id
			m.blue1_id = Team.where(number: truth[3]).first.id
			m.blue2_id = Team.where(number: truth[4]).first.id
			m.red_score = 0
			m.blue_score = 0
			m.event_id = event.id
			if m.save
				addToEvent(m) 
			end
		end
		updateEvent(event)
	end


	def checkMatches(data, event)
		matches = data.split("\n")

		missing = []
		wscore = []

		matches.each do |match|
			truth = match.split(" ")
			number = truth[0][2..-1].to_i
			scores = truth[1].split("-")

			m2 = event.matches.where(number: number).first
			if m2 == nil
				missing << number
			elsif m2.red_score != scores[0].to_i || m2.blue_score != scores[1].to_i
				wscore << number
			end
		end

		missing.each do |m|
			puts "Match #{m} is missing."
		end
		wscore.each do |w|
			puts "Match #{w} has a score error."
		end
	end
	
	def predictMatches(event)
		teams = event.teams

		map = {}
		teams.each do |t|
			opr = t.participations.where(event_id: event.id).first.opr
			map[t.id] = opr
		end

		pred = ""
		event.matches.each do |m|
			if !isPlayed(m)
				red_score = (map[m.red1_id] + map[m.red2_id]).round(0)
				blue_score = (map[m.blue1_id] + map[m.blue2_id]).round(0)
				pred += "Match #{m.number}: #{red_score}-#{blue_score} "
				if (red_score > blue_score)
					pred += "RED\n"
				elsif (blue_score > red_score)
					pred += "BLUE\n"
				else
					pred += "TIE\n"
				end
			end
		end
		pred
	end

end
