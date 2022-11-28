# frozen_string_literal: true

class AddResultToPalindroms < ActiveRecord::Migration[7.0]
  def change
    remove_column :palindroms, :res, :json
    add_column :palindroms, :result, :string
  end
end
