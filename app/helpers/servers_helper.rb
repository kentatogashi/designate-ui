module ServersHelper
  def server_list 
    response = RestClient.get "#{OS_ENDPOINT}/servers"
    if response.code == 200
      JSON.parse(response)
    else
      nil
    end
  end

  def server_create
  end

  def server_update
  end

end
