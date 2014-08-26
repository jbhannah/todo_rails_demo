json.status  @status
json.message @message

if current_user.is_admin?
  json.admin true
end

json.todo do
  json.(@todo, :id, :name, :completed)
end
