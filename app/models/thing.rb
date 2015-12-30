
# Sequel ORM representation of 'thing' table. This should have NO domain logic.
class Thing < Sequel::Model
  # Define some "scopes" (filters and/or ordering of the dataset)
  dataset_module do
    def for_index
      all.sort_by(&:id)
    end
  end # dataset_module
end
