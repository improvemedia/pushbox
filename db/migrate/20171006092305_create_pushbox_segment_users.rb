class CreatePushboxSegmentUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :pushbox_segment_users do |t|
      t.references :segment, foreign_key: { to_table: :pushbox_segments }
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
