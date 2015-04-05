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

end
