class ServersController < ApplicationController
  include ServersHelper

  def index
    @server_list = server_list
  end

  def create
    respond_to do |format|
      response = server_create params[:name]
      if response.present?
        format.html { redirect_to servers_url, notice: 'Server was successfully created.' }
      else
        format.html { redirect_to servers_url, notice: 'Creation was failed.' }
        format.html { render :new }
      end
    end
  end

  def update
  end

  def destroy
    response = server_destroy params[:name_id]
    if response.blank?
      respond_to do |format|
        format.html { redirect_to servers_url, notice: 'Server was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
        format.html { redirect_to servers_url, notice: 'Destroy was falied.' }
    end
  end
end
