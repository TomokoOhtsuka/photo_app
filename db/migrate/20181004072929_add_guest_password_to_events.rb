class AddGuestPasswordToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :guest_password, :string
  end
end
