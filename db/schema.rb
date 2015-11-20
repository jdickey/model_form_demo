Sequel.migration do
  change do
    create_table(:schema_migrations) do
      column :filename, "text", :null=>false
      
      primary_key [:filename]
    end
    
    create_table(:things) do
      primary_key :id
      column :name, "text"
      column :initial_quantity, "integer"
      column :description, "text"
    end
  end
end
Sequel.migration do
  change do
    self << "SET search_path TO \"$user\", public"
    self << "INSERT INTO \"schema_migrations\" (\"filename\") VALUES ('20151119175436_create_things.rb')"
  end
end
