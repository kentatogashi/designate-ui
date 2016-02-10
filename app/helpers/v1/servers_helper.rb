module V1
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
      begin
        response = RestClient.delete "#{os_endpoint}/#{name_id}"
      rescue => e
        id = server_id_by_server_name name_id
        response = RestClient.delete "#{os_endpoint}/#{id}"
      end
      if response.code == 200
        true
      else
        logger.debug(response)
        false
      end
    end

    def server_update
    end

    private 
    def os_endpoint
      "#{OS_ENDPOINT}/servers"
    end

    def server_id_by_server_name server
      response = RestClient.get os_endpoint
      json_res = JSON.parse(response)
      json_res["servers"].each do |s|
        return s["id"] if server == s["name"]
      end
      raise "Not found server id"
    end

  end
end
