class DropPeopleTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :person
  end
end
