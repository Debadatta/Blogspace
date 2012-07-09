class CreateSettings < ActiveRecord::Migration
  def change
    create_table :mcms_settings do |t|
      t.string :name, :null => true
      t.string :value, :null => true
      t.boolean :destroyable, :default => 1
      t.timestamps
    end

    add_index :mcms_settings, :name,     :unique => true
  end
end
