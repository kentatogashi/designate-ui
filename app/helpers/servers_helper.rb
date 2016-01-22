module ServersHelper

  def server_list 
    response = RestClient.get os_endpoint
    logger.debug(response)
    if response.code == 200
      JSON.parse(response)
    else
      logger.debug(response)
      false
    end
  end

  def server_create name
    response = RestClient.post os_endpoint, { 'name' => name }.to_json, 
      :content_type => :json, :accept => :json
    logger.debug(response)
    if response.code == 200
      JSON.parse(response)
    else
      false
    end
  end

  def server_destroy name_id
    response = RestClient.delete "#{os_endpoint}/#{name_id}"
    logger.debug(response)
    if response.code == 200
      true
    else
      false
    end
  end

  def server_update
  end

  private 
  def os_endpoint
    "#{OS_ENDPOINT}/servers"
  end

end
