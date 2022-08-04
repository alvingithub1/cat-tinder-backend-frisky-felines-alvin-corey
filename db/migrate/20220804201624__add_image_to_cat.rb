class AddImageToCat < ActiveRecord::Migration[7.0]
  def change
    add_column :cats, :image, :text
  end
end
