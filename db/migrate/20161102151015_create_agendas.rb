class CreateAgendas < ActiveRecord::Migration
  def change
    create_table :agendas do |t|
      t.belongs_to :user, index: true

      t.string :title
      t.text :description
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
