module AnalysisHelper
	require 'rubygems' if RUBY_VERSION < '1.9'
	require 'rest-client'
	require 'base64'

	def analyse_image(url)
		#入力されたurlからファイル情報を入手
		filename = File.basename(url)
		dirName = Rails.root.join('app', 'assets','images/').to_s
		filepath = dirName + filename

		# imagga apiのアカウント情報
		api_key = 'acc_ab4eb3f356b18fb'
		api_secret = '27799fc37e9319988e4fd959c678e62e'

		# ローカルに保存済みの画像をimaggaにアップロードする
		image_path = filepath
		auth = 'Basic ' + Base64.strict_encode64( "#{api_key}:#{api_secret}" ).chomp
		upload = RestClient.post "https://api.imagga.com/v2/uploads", { :image => File.new(image_path, 'rb') }, { :Authorization => auth }

		#アップロードした画像のimage_upload_idを代入
		image_upload_id = upload.match(/(?<=id":").*?(?="})/).to_s

		# アップロードした画像の分析
		response = RestClient.get "https://api.imagga.com/v2/tags?image_upload_id=#{image_upload_id}", { :Authorization => auth }
		# でバック用
		# response = {"result":{"tags":[{"confidence":100,"tag":{"en":"giant schnauzer"}},{"confidence":100,"tag":{"en":"schnauzer"}},{"confidence":100,"tag":{"en":"terrier"}},{"confidence":93.2460174560547,"tag":{"en":"dog"}},{"confidence":80.2177810668945,"tag":{"en":"hunting dog"}},{"confidence":48.5947380065918,"tag":{"en":"pet"}},{"confidence":38.6077651977539,"tag":{"en":"breed"}},{"confidence":37.8868980407715,"tag":{"en":"canine"}},{"confidence":31.2640590667725,"tag":{"en":"horse"}},{"confidence":28.6520328521729,"tag":{"en":"cute"}},{"confidence":28.4269618988037,"tag":{"en":"portrait"}},{"confidence":27.1361484527588,"tag":{"en":"purebred"}},{"confidence":27.0051441192627,"tag":{"en":"black"}},{"confidence":26.1743392944336,"tag":{"en":"puppy"}},{"confidence":23.5092544555664,"tag":{"en":"brown"}},{"confidence":20.9566822052002,"tag":{"en":"head"}},{"confidence":20.5162010192871,"tag":{"en":"grass"}},{"confidence":20.1159992218018,"tag":{"en":"pets"}},{"confidence":19.8590908050537,"tag":{"en":"domestic"}},{"confidence":19.5023975372314,"tag":{"en":"pedigree"}},{"confidence":19.4781169891357,"tag":{"en":"fur"}},{"confidence":19.0166568756104,"tag":{"en":"friend"}},{"confidence":18.697582244873,"tag":{"en":"farm"}},{"confidence":17.5793380737305,"tag":{"en":"stallion"}},{"confidence":17.5664367675781,"tag":{"en":"animals"}},{"confidence":16.6905136108398,"tag":{"en":"studio"}},{"confidence":16.6170043945312,"tag":{"en":"hair"}},{"confidence":15.6628847122192,"tag":{"en":"equestrian"}},{"confidence":14.5606002807617,"tag":{"en":"guard"}},{"confidence":14.3707056045532,"tag":{"en":"looking"}},{"confidence":14.3211259841919,"tag":{"en":"meadow"}},{"confidence":13.6918210983276,"tag":{"en":"equine"}},{"confidence":13.086386680603,"tag":{"en":"friendship"}},{"confidence":12.8624258041382,"tag":{"en":"sitting"}},{"confidence":12.6692790985107,"tag":{"en":"outdoors"}},{"confidence":12.5242319107056,"tag":{"en":"field"}},{"confidence":12.5188207626343,"tag":{"en":"furry"}},{"confidence":11.9582452774048,"tag":{"en":"outside"}},{"confidence":11.7560758590698,"tag":{"en":"pedigreed"}},{"confidence":11.6935148239136,"tag":{"en":"ranch"}},{"confidence":11.4707527160645,"tag":{"en":"little"}},{"confidence":11.0590915679932,"tag":{"en":"adorable"}},{"confidence":10.6789989471436,"tag":{"en":"outdoor"}},{"confidence":10.5505504608154,"tag":{"en":"rural"}},{"confidence":10.4350128173828,"tag":{"en":"one"}},{"confidence":10.2688550949097,"tag":{"en":"summer"}},{"confidence":10.2533092498779,"tag":{"en":"close"}},{"confidence":10.1819581985474,"tag":{"en":"sky"}},{"confidence":10.0049886703491,"tag":{"en":"happy"}},{"confidence":9.8082218170166,"tag":{"en":"attentive"}},{"confidence":9.79718112945557,"tag":{"en":"mare"}},{"confidence":9.79465484619141,"tag":{"en":"doggy"}},{"confidence":9.72220325469971,"tag":{"en":"horses"}},{"confidence":9.61619758605957,"tag":{"en":"look"}},{"confidence":9.20931720733643,"tag":{"en":"male"}},{"confidence":9.16308879852295,"tag":{"en":"funny"}},{"confidence":9.03975200653076,"tag":{"en":"adult"}},{"confidence":8.96217632293701,"tag":{"en":"fun"}},{"confidence":8.83913993835449,"tag":{"en":"pup"}},{"confidence":8.79052639007568,"tag":{"en":"mane"}},{"confidence":8.67837810516357,"tag":{"en":"standing"}},{"confidence":8.6735258102417,"tag":{"en":"ears"}},{"confidence":8.66744613647461,"tag":{"en":"run"}},{"confidence":8.62747287750244,"tag":{"en":"jump"}},{"confidence":8.62069988250732,"tag":{"en":"collar"}},{"confidence":8.61640071868896,"tag":{"en":"spring"}},{"confidence":8.59194850921631,"tag":{"en":"eyes"}},{"confidence":8.3295783996582,"tag":{"en":"action"}},{"confidence":7.88309335708618,"tag":{"en":"loyal"}},{"confidence":7.8740553855896,"tag":{"en":"hound"}},{"confidence":7.86097860336304,"tag":{"en":"stable"}},{"confidence":7.8376612663269,"tag":{"en":"companion"}},{"confidence":7.82760858535767,"tag":{"en":"miniature"}},{"confidence":7.80548572540283,"tag":{"en":"hairy"}},{"confidence":7.78521347045898,"tag":{"en":"riding"}},{"confidence":7.77743577957153,"tag":{"en":"alert"}},{"confidence":7.75713920593262,"tag":{"en":"staring"}},{"confidence":7.66467189788818,"tag":{"en":"person"}},{"confidence":7.64618110656738,"tag":{"en":"pasture"}},{"confidence":7.61405038833618,"tag":{"en":"nose"}},{"confidence":7.59810590744019,"tag":{"en":"cut out"}},{"confidence":7.39990282058716,"tag":{"en":"sport"}},{"confidence":7.2830057144165,"tag":{"en":"playing"}},{"confidence":7.17540407180786,"tag":{"en":"active"}},{"confidence":7.13666677474976,"tag":{"en":"eye"}}]},"status":{"text":"","type":"success"}}

		# 分析結果を信頼度％とタグ付けで分ける
		responses = response.to_s.scan(/(?<=)confidence.*?(?=}},)/)

		# 信頼度
		keys = []
		# タグ
		values = []

		responses.each do |rs|
			keys << rs.scan(/(?<=confidence":).*?(?=,)/)
			values << rs.scan(/(?<=en":").*?(?=")/)
			# # debug
			# keys << rs.scan(/(?<=confidence=>).*?(?=,)/)
			# values << rs.scan(/(?<=en=>").*?(?=")/)
		end

		# 信頼度の整数化
		keys_i = []
		keys.each do |ks|
		  ks.each do |kss|
		    keys_i << kss.to_i
		  end
		end
		# 信頼度とタグをハッシュ化
		results = [keys_i,values].transpose

		# 各imageのIDを取得
		image_id = Image.find_by(name:"#{filename}").id

		results.each do |conf,tag|
		  if conf > 70
	  		feed = ConfidenceTag.new(:image_id => image_id,:confidence => conf, :tag => tag)
	  		feed.save
		  end
		end
	end
end