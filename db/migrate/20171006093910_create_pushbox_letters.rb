class CreatePushboxLetters < ActiveRecord::Migration[5.1]
  def change
    create_table :pushbox_letters do |t|
      t.string :title, null: false
      t.references :pushbox_templates
      t.datetime :start_at

      t.timestamps
    end
  end
end
