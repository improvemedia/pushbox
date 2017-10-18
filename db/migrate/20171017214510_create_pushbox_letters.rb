class CreatePushboxLetters < ActiveRecord::Migration[5.1]
  def change
    create_table :pushbox_letters do |t|
      t.references :pushbox_mailings, foreign_key: true
      t.references :users, foreign_key: true
      t.string :state
      t.text :content

      t.timestamps
    end
  end
end
