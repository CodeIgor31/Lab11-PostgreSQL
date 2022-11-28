# frozen_string_literal: true

# good
class Palindrom < ApplicationRecord
  include ActiveModel::Serializers::Xml
  self.primary_key = :num
end
