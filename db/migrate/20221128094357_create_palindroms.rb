class CreatePalindroms < ActiveRecord::Migration[7.0]
  def change
    create_table :palindroms, id: false do |t|
      t.integer :num, null: false
      t.json :res
    end
    execute "ALTER TABLE palindroms ADD PRIMARY KEY (num);"
    add_index :palindroms, [:num], unique: true
  end
end