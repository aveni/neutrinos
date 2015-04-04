class RemoveDescriptionFromMatches < ActiveRecord::Migration
  def change
  	remove_column :matches, :description, :text
  end
end
