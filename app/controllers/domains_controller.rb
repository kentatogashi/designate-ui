class DomainsController < ApplicationController

  include DomainsHelper

  def index
    @domain_list = domain_list
  end

  def create
    response = domain_create params[:name], params[:ttl].to_i, params[:email]
    respond_to do |format|
      if response.present?
        format.html {redirect_to domains_url, notice: 'Domain was successfully created.'}
      else
        format.html {redirect_to domains_url, notice: 'Creation was failed.'}
        format.html { render :new }
      end
    end
  end

  def destroy
    response = domain_delete params[:name_id]
    respond_to do |format|
      if response.blank?
        format.html {redirect_to domains_url, notice: 'Domain was successfully destroyed.'}
      else
        format.html {redirect_to domains_url, notice: 'Deletion was falied'}
      end
    end
  end
end
