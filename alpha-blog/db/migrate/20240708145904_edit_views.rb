class EditViews < ActiveRecord::Migration[7.1]
  def change
    change_column_default :articles, :views, from: nil, to: 0
  end
end
