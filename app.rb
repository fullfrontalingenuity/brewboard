#!/usr/bin/env ruby

require 'yaml'
require 'json'
require 'sinatra'
require 'net/http'
require "sinatra"
require "sinatra/activerecord"

set :bind, '0.0.0.0'
 
set :database, "sqlite3:db/brews.db"
require './models' 

current_dir = File.dirname(__FILE__)
#brews = YAML::load_file(File.join(current_dir, '_data/brews.yml'))
#puts brews

def validate params
  errors = {}
  #[:id_0, :name_0].each{|key| params[key] = (params[key] || "").strip }
  #errors[:id_0]    = "ID field: " + params[:id_0]
end

##### GET METHODS

get '/' do
  @brews = Brew.order("color DESC")
  erb :index
end

get '/edit' do
  @brews = Brew.order("id ASC")
  erb :edit
end

# list all in default (yaml)
get '/brews' do
  @brews = Brew.order("id ASC")
  @brews.to_yaml
end

# view single brew by ID (yaml)
get "/brew/:id" do
  @brew = Brew.find(params[:id])
  @name = @brew.name
  erb :"brew"
end

# view brews marked as soldout
get '/brews/soldout' do
  soldout = brews.select {|items| items['soldout'] == true }
  #return status 404 if soldout.nil
  soldout.to_yaml
end

##### POST METHODS

# Admin form
post '/edit' do

end

# create new brew
post '/brew' do
  brew = brews.new(params['brew'])
  brew.save
  status 201
end

##### PUT METHODS

# update brew by ID
put "/brew/:id" do
  @brew = Brew.find(params[:id])
  if @brew.update_attributes(params[:brew])
    puts "successful update {@brew.id}"
    redirect "/edit"
  else
    erb :"error"
  end
end

##### DELETE METHODS

# delete brew by ID

delete "/brew/:id" do
  @brew = Brew.find(params[:id]).destroy
  redirect "/edit"
end

