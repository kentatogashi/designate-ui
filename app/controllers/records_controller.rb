class RecordsController < ApplicationController

  include RecordsHelper

  def index
    @record_list = nil
  end

  def create
    response = record_create params[:domain_id], params[:name], params[:type], params[:data]
    respond_to do |format|
      if response.present?
        format.html {redirect_to records_url, notice: 'Record was successfully created.'}
      else
        format.html {redirect_to records_url, notice: 'Creation was failed.'}
      end
    end
  end

  def destroy
    response = record_delete params[:domain_id], params[:name_id]
    respond_to do |format|
      if response.blank?
        format.html {redirect_to records_url, notice: 'Record was successfully destroyed.'}
      else
        format.html {redirect_to records_url, notice: 'Deletion was falied'}
      end
    end
  end

  def ajax_search
    @record_list = record_list params[:domain_id]
    logger.debug(@record_list)
    render
  end
end
