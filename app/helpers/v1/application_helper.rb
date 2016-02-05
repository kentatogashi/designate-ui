module V1
  module ApplicationHelper
    def domain_id_by_domain domain
      response = RestClient.get "#{OS_ENDPOINT}/domains"
      logger.debug(response)
      if response.code == 200
        domain_list = JSON.parse(response)
      else
        raise "cannot get domain list"
      end
      domain_list["domains"].each do |dom|
        if dom["name"] == domain
          return dom["id"]
        end
      end
      raise "not found domain id"
    end
  end
end
