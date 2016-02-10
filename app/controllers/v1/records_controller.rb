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
      if response.present?
        flash[:success] = 'Creation was done'
      else
        flash[:error] = 'Failed to creation'
      end
      redirect_to v1_records_url
    end

    def destroy
      response = record_delete params[:domain], params[:name_id]
      if response.blank?
        flash[:success] = 'Deletion was done'
      else
        flash[:error] = 'Failed to deletion'
      end
      redirect_to v1_records_url
    end

    def ajax_search
      @record_list = record_list params[:domain]
      logger.debug(@record_list)
      render
    end
  end
end
