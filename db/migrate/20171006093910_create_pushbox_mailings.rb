class CreatePushboxMailings < ActiveRecord::Migration[5.1]
  def change
    create_table :pushbox_mailings do |t|
      t.string :title, null: false
      t.references :template, foreign_key: { to_table: :pushbox_templates }
      t.references :segment, foreign_key: { to_table: :pushbox_segments }
      t.string :state
      t.string :dispatch_state
      t.datetime :dispatch_at

      t.timestamps
    end
  end
end
