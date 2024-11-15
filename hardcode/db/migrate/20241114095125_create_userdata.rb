class CreateUserdata < ActiveRecord::Migration[7.2]
  def change
    create_table :userdata do |t|
      t.timestamps
    end
  end
end
