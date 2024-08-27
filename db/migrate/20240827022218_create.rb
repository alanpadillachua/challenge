class Create < ActiveRecord::Migration[6.1]
  def change
    create_table :subscribers do |s|
      s.string :name, null: false
      s.string :email, null: false, unique: true
      s.string :status, null: false, default: "active"
      s.timestamps
    end
  end
end
