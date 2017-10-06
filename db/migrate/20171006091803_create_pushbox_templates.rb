class CreatePushboxTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :pushbox_templates do |t|
      t.string :title, null: false
      t.text :body

      t.timestamps
    end
  end
end
