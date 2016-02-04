module V1
  class RecordsController < ApplicationController

    include V1::RecordsHelper

    def index
      @record_list = nil
    end

    def create
      params_hash = {
        domain:   params[:domain],
        name:     params[:name],
        type:     params[:type],
        data:     params[:data],
        priority: params[:priority].to_i || nil
      }
      response = record_create params_hash
      respond_to do |format|
        if response.present?
          format.html {redirect_to records_url, notice: 'Record was successfully created.'}
        else
          format.html {redirect_to records_url, notice: 'Creation was failed.'}
        end
      end
    end

    def destroy
      response = record_delete params[:domain], params[:name_id]
      respond_to do |format|
        if response.blank?
          format.html {redirect_to records_url, notice: 'Record was successfully destroyed.'}
        else
          format.html {redirect_to records_url, notice: 'Deletion was falied'}
        end
      end
    end

    def ajax_search
      @record_list = record_list params[:domain]
      logger.debug(@record_list)
      render
    end
  end
end
