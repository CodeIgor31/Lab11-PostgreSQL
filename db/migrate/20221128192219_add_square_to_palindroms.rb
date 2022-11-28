# frozen_string_literal: true

# fourth migrat
class AddSquareToPalindroms < ActiveRecord::Migration[7.0]
  def change
    remove_column :palindroms, :count, :integer
    add_column :palindroms, :squares, :string
    add_column :palindroms, :count, :integer
  end
end
