Sequel.migration do 
  change do

    create_table :things do
      primary_key :id
      String :name
      Integer :initial_quantity
      String :description
    end

  end
end
