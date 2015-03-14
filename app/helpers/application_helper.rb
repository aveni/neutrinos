module ApplicationHelper

	def blue(text)
		content_tag(:span, text, class: "label label-info label-as-badge")
	end

	def red(text)
		content_tag(:span, text, class: "label label-danger label-as-badge")
	end
end
