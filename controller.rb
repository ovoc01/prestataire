# frozen_string_literal: true
# import
require 'sinatra'
require 'pg'
require_relative 'connection'
require_relative  'road'
require_relative 'utils'

c = Connection.new.pgCon()
get '/' do
  list_road = Road.allRoad(c)
  erb :index, :locals => {:road_list =>list_road}
end

post '/list_prestataire' do
  id_road = params['rn']
  list = Utils.list_prestataire(id_road,c)
  erb :list , :locals => {:prestataire => list}
end