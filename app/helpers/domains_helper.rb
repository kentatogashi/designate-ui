module DomainsHelper
  def domain_list
    response = RestClient.get os_endpoint
    logger.debug(response)
    if response.code == 200
      JSON.parse(response)
    else
      false
    end
  end

  def domain_create name, ttl, email
    logger.debug({'name' => name, 'ttl' => ttl, 'email' => email }.to_json)
    response = RestClient.post "#{os_endpoint}", {:name => name, :ttl => ttl, :email => email}.to_json,
      :content_type => :json, :accept => :json
    logger.debug(response)
    if response.code == 200
      JSON.parse(response)
    else
      false
    end
  end

  def domain_delete name_id
    logger.debug("#{os_endpoint}/#{name_id}")
    response = RestClient.delete "#{os_endpoint}/#{name_id}"
    logger.debug(response)
    if response.code == 200
      true
    else
      false
    end
  end

  def os_endpoint
    "#{OS_ENDPOINT}/domains"
  end
end
