class AddUserToFlats < ActiveRecord::Migration[6.1]
  def change
    add_reference :flats, :user, index: true, foreign_key: true
  end
end
