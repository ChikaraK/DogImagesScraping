class CreateConfidenceTags < ActiveRecord::Migration[5.2]
  def change
    create_table :confidence_tags do |t|
      t.timestamps
    end
  end
end
