class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :original
      t.string :short
      t.string :title
      t.integer :popularity

      t.timestamps null: false
    end
  end
end
