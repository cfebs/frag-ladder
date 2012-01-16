class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :real_name
      t.string :alias
      t.boolean :active

      t.timestamps
    end
  end
end
