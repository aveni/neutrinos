module ApplicationHelper

	def blue(text)
		content_tag(:span, text, class: "label label-info label-as-badge")
	end

	def red(text)
		content_tag(:span, text, class: "label label-danger label-as-badge")
	end

	def resetAllParticipations
		Team.all.each do |t|
			matches = getMatches(t)
			matches.each do |m|
				if Participation.where(team_id: t.id, event_id: m.event.id) == nil
					p = Participation.create(team_id: t.id, event_id: m.event.id)
					p.save
				end
			end
		end
		Participation.all.each {|p| updateParticipation(p)}
	end

end
