# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  scope :published, -> {}

  class << self
    def ransackable_attributes(_auth_object = nil)
      column_names
    end

    def ransackable_associations(_auth_object = nil)
      reflect_on_all_associations.map { |association| association.name.to_s }
    end
  end
end
