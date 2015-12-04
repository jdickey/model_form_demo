
module FormObjects
  # All the logic needed to create a new Thing record based on input parameters.
  class CreateThing
    # Encapsulates testing whether a set of ORM attributes are "unique". This is
    # true if either of the following conditions is true:
    # 1. No ORM instance exists whose name field has the same name, OR
    # 2. An ORM instance exists with ALL fields matching the attributes, whereby
    #    it is presumed to be the "same" record. We really should ensure that a
    #    database constraint is set to force that.
    class Uniqueness
      def initialize(attributes)
        @attributes = attributes
        self
      end

      def unique?
        !existing || same_instance?
      end

      private

      attr_reader :attributes

      def existing
        @existing ||= Thing.find(name: attributes[:name])
      end

      def existing_attributes
        existing.values.except(:id)
      end

      def same_instance?
        attributes == existing_attributes
      end
    end # class FormObjects::CreateThing::Uniqueness
  end # class FormObjects::CreateThing
end
