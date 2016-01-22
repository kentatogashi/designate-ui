json.array!(@servers) do |server|
  json.extract! server, :id, :name, :status
  json.url server_url(server, format: :json)
end
