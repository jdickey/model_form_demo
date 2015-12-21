
module FormObjects
  # All the logic needed to create a new Thing record based on input parameters.
  class CreateThing
    # Error to be raised when validation of a CreateThing instance fails.
    class ValidationError < RuntimeError
      include Virtus.model(strict: true)

      def initialize(invalid_attributes:, errors_found:)
        @invalid_attributes = invalid_attributes
        @errors_found = errors_found
        super()
      end

      def message
        ['Validation of Thing attributes failed. Invalid attributes:',
         "#{invalid_attributes}, errors found: #{errors_found.full_messages}"
        ].join ' '
      end

      values do
        attribute :invalid_attributes, Array[String]
        attribute :errors_found, ActiveModel::Errors
      end
    end # class FormObjects::CreateThing::ValidationError
  end # class FormObjects::CreateThing
end
