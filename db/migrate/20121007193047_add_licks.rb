class AddLicks < ActiveRecord::Migration
  def change
    create_table :licks do |t|
      t.belongs_to :user
      t.belongs_to :link
  
      t.timestamps
    end
  end
end
