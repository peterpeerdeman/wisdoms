class AddUserRefToWisdoms < ActiveRecord::Migration
  def change
    add_reference :wisdoms, :user, index: true
  end
end
