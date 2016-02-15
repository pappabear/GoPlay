class AddFormattedAddressToVenues < ActiveRecord::Migration
  def change
    add_column :venues, :formatted_address, :string
  end
end
