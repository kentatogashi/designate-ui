module RecordsHelper
  def record_list
  end

  def record_create domain_id, name, type, data
    response = RestClient.post "#{os_endpoint}/#{domain_id}/records", {:name => name, :type => type, :data => data}.to_json, content_type: :json, accept: :json
    logger.debug(response)
    if response.code == 200
      JSON.parse(response)
    else
      false
    end
  end

  def record_delete name_id
  end

  def record_list domain_id
    response = RestClient.get "#{os_endpoint}/#{domain_id}/records"
    logger.debug(response)
    if response.code == 200
      JSON.parse(response)
    else
      false
    end
  end

  def os_endpoint
    "#{OS_ENDPOINT}/domains"
  end
end
