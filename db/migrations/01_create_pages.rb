Sequel.migration do
  change do
    create_table(:pages) do
      primary_key :id
      String :url, null: false, unique: true
      File :body, null: false

      index :id
      index :url
    end
  end
end
