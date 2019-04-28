class ImagesController < ApplicationController
	include ImagesHelper
	include AnalysisHelper
	def index
		@images = Image.all
	end

	def input
		@image = Image.new
	end

	def download
		search_word = URI.encode(params[:search_word])
		if search_word == ""
			redirect_to root_path
		else
			doc = Nokogiri::HTML(open(
				"https://www.flickr.com/search/?q=#{search_word}"))
			doc.xpath("//div[@class='view photo-list-photo-view requiredToShowOnServer awake']").each do |link|
				url = link.to_s.match(/https.*?jpg|png|jpeg/)
				#サムネ
				save_image(url[0])
				analyse_image(url[0])
				sleep(1)
			end
			redirect_to images_path
		end
	end
end
