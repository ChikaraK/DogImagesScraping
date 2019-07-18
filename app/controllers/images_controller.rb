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
		# 前回の履歴を消す
		images = Image.all
		if !images.empty?
			images.each do |i|
				i.destroy
			end
		end

		# 結果表示
		search_word = URI.encode(params[:search_word])
		if search_word == ""
			redirect_to root_path
		else
			doc = Nokogiri::HTML(open(
				"https://www.flickr.com/search/?q=#{search_word}"))
			doc.xpath("//div[@class='view photo-list-photo-view requiredToShowOnServer awake']").each do |link|
				url = link.to_s.match(/live.*?jpg|png|jpeg/)
				#サムネ
				save_image(url[0])
				analyse_image(url[0])
				sleep(1)
			end
			redirect_to images_path
		end
	end
end