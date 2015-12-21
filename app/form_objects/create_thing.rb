
require 'virtus'

require_relative 'create_thing/uniqueness'
require_relative 'create_thing/validation_error'

module FormObjects
  # All the logic needed to create a new Thing record based on input parameters.
  class CreateThing
    include SemanticLogger::Loggable
    include Virtus.model
    include ActiveModel::Validations

    attribute :name, String
    attribute :initial_quantity, Integer
    attribute :description, String

    validates :name, presence: true
    validates :initial_quantity, numericality: {
      greater_than_or_equal_to: 1,
      only_integer: true
    }
    validates :description, presence: true, allow_blank: false
    validate :unique?

    def new?
      !Thing.find(name: name)
    end

    def save
      validate_before_save
      new_record.save
      self
    end

    private

    def add_uniquness_failure_error
      errors.add :name, 'has already been added. Please enter a new one.'
    end

    def can_save?
      valid? && unique?
    end

    def new_record
      Thing.new attributes
    end

    # Since we don't keep track of record IDs in this class, we have to wing it
    # using attributes.
    def unique?
      return true if Uniqueness.new(attributes).unique?
      add_uniquness_failure_error
      false
    end

    def validate_before_save
      fail validation_error unless can_save?
    end

    def validation_error
      ValidationError.new invalid_attributes: attributes, errors_found: errors
    end
  end # class FormObjects::CreateThing
end
