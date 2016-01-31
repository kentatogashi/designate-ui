require 'rails_helper'

RSpec.describe ServersHelper, :type => :helper do

  describe "Servers API" do

    before do
      include ServersHelper
      @test_server = 'ns7.example.com.'
    end

    it "create test server" do
      res = server_create @test_server
      expect(res["name"]).to eq @test_server
    end

    it "list test server" do
      match = false
      list = server_list
      list["servers"].each do |server|
        if server['name'] == @test_server
          match = true
        end
      end
      expect(match).to be true
    end

    it "destroy test server" do
      list = server_list 
      list["servers"].each do |server|
        if server['name'] == @test_server
          domain_id = server['id']
	  res = server_destroy domain_id
	  expect(res).to be true
        end
      end
    end

  end
end
