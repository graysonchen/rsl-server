Sequel.migration {
  change do
    create_table :logs do
      primary_key :id
      Text :content
      DateTime :created_at
      DateTime :updated_at
    end
  end
}
