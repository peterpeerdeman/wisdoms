class CreateWisdoms < ActiveRecord::Migration
  def change
    create_table :wisdoms do |t|
      t.text :quote
      t.string :author

      t.timestamps
    end
  end
end
