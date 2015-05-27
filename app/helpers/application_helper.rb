module ApplicationHelper

	include HtmlBuilder
	def document_title
		if @title.present?
			"#{@title} - Estheloan"
		else
			"Estheloan"
		end
	end
end
