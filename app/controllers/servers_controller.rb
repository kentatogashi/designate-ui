class ServersController < ApplicationController
  include ServersHelper

  def index
    @server_list = server_list
  end

  def create
    respond_to do |format|
      response = server_create params[:name]
      if response.present?
        flash[:notice] = "Server was successfully created."
      else
        flash[:error] = "Creation was failed."
      end
      redirect_to v1_servers_url
    end
  end

  def update
  end

  def destroy
    response = server_destroy params[:name_id]
    if response
      flash[:notice] = "Server was successfully destroyed"
    else
      flash[:error] = "Destroy was failed"
    end
      redirect_to v1_servers_url
  end
end
