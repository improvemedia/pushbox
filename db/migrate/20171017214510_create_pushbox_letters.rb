class CreatePushboxLetters < ActiveRecord::Migration[5.1]
  def change
    create_table :pushbox_letters do |t|
      t.references :mailing, foreign_key: { to_table: :pushbox_mailings }
      t.references :user, foreign_key: true
      t.string :state
      t.string :subject
      t.text :content

      t.timestamps
    end
  end
end
