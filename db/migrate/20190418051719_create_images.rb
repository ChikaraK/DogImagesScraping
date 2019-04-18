class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
    	t.string :name # 画像の名前
 		t.binary :data # 画像データ
      	t.timestamps
    end
  end
end
