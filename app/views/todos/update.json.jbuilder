json.status  @status
json.message @message

json.todo do
  json.(@todo, :id, :name, :completed)
end
