class CreateLink < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url, null:false
      t.text :description
      t.belongs_to :user
      
      t.timestamps
    end
  end
end
