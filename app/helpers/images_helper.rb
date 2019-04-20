module ImagesHelper
	require 'open-uri'
	require 'nokogiri'
	def save_image(url)
		filename = File.basename(url)
		dirName = Rails.root.join('app', 'assets','images/').to_s
		filepath = dirName + filename
		open(filepath,'wb') do |file|
			open(url) do |data|
				file.write(data.read)
			end
		end
		feed = Image.new(:name  => filename,:data => filepath)
		feed.save
	end
end
