class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|

    	t.string :number
    	t.belongs_to :blue1
    	t.belongs_to :blue2
    	t.belongs_to :red1
    	t.belongs_to :red2
      t.integer :red_score
      t.integer :blue_score

      t.references :event
      t.timestamps null: false
    end
  end
end
