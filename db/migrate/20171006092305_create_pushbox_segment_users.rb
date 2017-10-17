class CreatePushboxSegmentUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :pushbox_segment_users do |t|
      t.references :pushbox_segments, foreign_key: true
      t.references :users, foreign_key: true

      t.timestamps
    end
  end
end
