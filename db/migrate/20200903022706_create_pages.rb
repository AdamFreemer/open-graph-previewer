class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :url
      t.string :og_image
      t.boolean :processed

      t.timestamps
    end
  end
end
