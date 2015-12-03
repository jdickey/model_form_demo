
require 'virtus'

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
    validate :unique_thing_name?

    def new?
      !Thing.find(name: name)
    end

    def save
      validate
      new_record.save
      self
    end

    private

    def new_record
      Thing.new attributes
    end

    def unique_thing_name?
      existing = Thing.find(name: name)
      return unless existing
      errors.add :name, 'has already been added. Please enter a new one.'
    end

    def validate
      # rubocop:disable Style/RaiseArgs, Style/SignalException
      raise ValidationError.new(invalid_attributes: attributes,
                                errors_found: errors) unless valid?
      # rubocop:enable  Style/RaiseArgs, Style/SignalException
      self
    end
  end # class FormObjects::CreateThing
end
