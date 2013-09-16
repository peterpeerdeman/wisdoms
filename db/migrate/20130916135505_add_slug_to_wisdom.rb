class AddSlugToWisdom < ActiveRecord::Migration
  def change
    add_column :wisdoms, :slug, :string, unique: true
  end
end
