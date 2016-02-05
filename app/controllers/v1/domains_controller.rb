module V1
  class DomainsController < ApplicationController

    include V1::DomainsHelper

    def index
      @domain_list = domain_list
    end

    def create
      response = domain_create params[:name], params[:ttl].to_i, params[:email]
      respond_to do |format|
        if response.present?
          format.html {redirect_to v1_domains_url, notice: 'Domain was successfully created.'}
        else
          format.html {redirect_to v1_domains_url, notice: 'Creation was failed.'}
          format.html { render :new }
        end
      end
    end

    def ajax_search
      @domain = domain_search params[:domain]
      render
    end

    def destroy
      response = domain_delete params[:name_id]
      respond_to do |format|
        if response.blank?
          format.html {redirect_to v1_domains_url, notice: 'Domain was successfully destroyed.'}
        else
          format.html {redirect_to v1_domains_url, notice: 'Deletion was falied'}
        end
      end
    end
  end
end

