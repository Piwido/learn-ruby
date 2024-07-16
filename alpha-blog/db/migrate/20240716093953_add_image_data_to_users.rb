class AddImageDataToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :image_data, :text
  end
end
