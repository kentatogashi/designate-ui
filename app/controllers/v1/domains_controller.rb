module V1
  class DomainsController < ApplicationController

    include V1::DomainsHelper

    def index
      @domain_list = domain_list
    end

    def create
      response = domain_create params[:name], params[:ttl].to_i, params[:email]
      if response.present?
        flash[:success] = 'Creation was done'
      else
        flash[:error] = 'Failed to create domaind'
      end
      redirect_to v1_domains_url
    end

    def ajax_search
      @domain = domain_search params[:domain]
      render
    end

    def destroy
      response = domain_delete params[:name_id]
      if response.blank?
        flash[:success] = 'Deletion was done'
      else
        flash[:error] = 'Failed to delete domain'
      end
      redirect_to v1_domains_url
    end
  end
end
