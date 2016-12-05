class CreateExecuters < ActiveRecord::Migration
  def change
    create_table :executers do |t|

      t.timestamps null: false
    end
  end
end
