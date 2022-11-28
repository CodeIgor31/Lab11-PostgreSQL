# frozen_string_literal: true

class AddCountToPalindroms < ActiveRecord::Migration[7.0]
  def change
    add_column :palindroms, :count, :integer
  end
end
