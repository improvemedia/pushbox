class CreatePushboxMailings < ActiveRecord::Migration[5.1]
  def change
    create_table :pushbox_mailings do |t|
      t.string :title, null: false
      t.references :pushbox_templates, foreign_key: true
      t.references :pushbox_segments, foreign_key: true
      t.string :state
      t.string :dispatch_state
      t.datetime :dispatch_at

      t.timestamps
    end
  end
end
