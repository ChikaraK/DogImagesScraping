class ChangeDatatypeImages < ActiveRecord::Migration[5.2]
	def change
	    add_column :confidence_tags, :image_id, :integer #imagesテーブルのPK
	    add_column :confidence_tags, :confidence, :integer #信頼度
		add_column :confidence_tags, :tag, :string #タグ

	end

end
