# frozen_string_literal: true

# good
class Palindrom < ApplicationRecord
  include ActiveModel::Serializers::Xml
  validates :num, uniqueness: true
  validates_numericality_of :num, :only_integer => true, :greater_than_or_equal_to => 0
  self.primary_key = :num
end
