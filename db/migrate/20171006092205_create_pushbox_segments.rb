class CreatePushboxSegments < ActiveRecord::Migration[5.1]
  def change
    create_table :pushbox_segments do |t|
      t.string :title
      t.string :state

      t.timestamps
    end
  end
end
