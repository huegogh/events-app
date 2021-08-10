class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :event_type
      t.jsonb :raw_data

      t.timestamps
    end
  end
end
