module V1
  class ServersController < ApplicationController
    include V1::ServersHelper

    def index
      @server_list = server_list
    end

    def create
        response = server_create params[:name]
        if response.present?
          flash[:success] = "Creation was done"
        else
          flash[:error] = "Failed to create server"
        end
        redirect_to v1_servers_url
    end

    def destroy
      response = server_destroy params[:name_id]
      if response
        flash[:success] = "Deletion was done"
      else
        flash[:error] = "Failed to delete server"
      end
      redirect_to v1_servers_url
    end
  end
end
