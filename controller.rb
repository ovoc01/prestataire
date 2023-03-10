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
  road = Utils.getSpecific_road(id_road,c)
  list = Utils.list_prestataire(id_road,c)
  puts "tay"
  f = road.formula(c)
  erb :list , :locals => {:prestataire => list,:rn =>road,:formula =>f[0]}
end

get '/index' do
  erb :home
end