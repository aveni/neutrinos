module EventsHelper
	def show_date(event)
		"#{event.month}/#{event.day}/#{event.year}"
	end

	def show_level(event)
		content_tag(:span, event.level, class: "label label-warning label-as-badge")
	end
end
