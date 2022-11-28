# frozen_string_literal: true

# Second migrat
class AddResultToPalindroms < ActiveRecord::Migration[7.0]
  def change
    remove_column :palindroms, :res, :json
    add_column :palindroms, :result, :string
  end
end
