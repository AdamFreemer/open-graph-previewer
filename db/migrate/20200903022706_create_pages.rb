class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :page_url
      t.string :og_image_url
      t.boolean :processed, default: false
      t.timestamps
    end
  end
end
