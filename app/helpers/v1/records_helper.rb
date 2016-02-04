module V1
  module RecordsHelper
    def record_list
    end

    def record_create params

      if params[:type] != 'MX'
        params.delete(:priority)
      end

      domain_id = domain_id_by_domain params[:domain]
      params.delete(:domain)

      logger.debug(params.to_json)
      response = RestClient.post "#{os_endpoint}/#{domain_id}/records", params.to_json, content_type: :json, accept: :json
      logger.debug(response)
      if response.code == 200
        JSON.parse(response)
      else
        false
      end
    end

    def record_delete domain, record_id
      domain_id = domain_id_by_domain domain
      response = RestClient.delete "#{os_endpoint}/#{domain_id}/records/#{record_id}"
      logger.debug(response)
      if response.code == 200
        true
      else
        false
      end
    end

    def record_list domain
      domain_id = domain_id_by_domain domain
      response = RestClient.get "#{os_endpoint}/#{domain_id}/records"
      logger.debug(response)
      if response.code == 200
        JSON.parse(response)
      else
        false
      end
    end

    private
    def domain_id_by_domain domain
      response = RestClient.get os_endpoint
      logger.debug(response)
      if response.code == 200
        domain_list = JSON.parse(response)
      else
        raise "cannot get domain list"
      end
      domain_list["domains"].each do |dom|
        if dom["name"] == domain
          logger.debug(dom["id"])
          return dom["id"]
        end
      end
      raise "cannot search domain id"
    end

    def os_endpoint
      "#{OS_ENDPOINT}/domains"
    end
  end
end
