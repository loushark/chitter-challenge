require 'sinatra/base'
require './lib/peep'
require './lib/user'

class Chitter < Sinatra::Base
  configure do
    set :public_folder, File.expand_path('public', __dir__)
  end

  enable :sessions

  get '/' do
    session[:current_user] = "a Guest"
    erb :chitter
  end

  get '/sign_up' do
    erb :sign_up
  end

  post '/sign_up' do
    User.add(params[:name], params[:username], params[:email], params[:password])
    session[:current_user] = params[:username]
    redirect '/peeps'
  end

  get '/login' do
    erb :login
  end

  post '/login' do
    session[:current_user] = params[:username]
    redirect '/peeps'
  end

  get '/logout' do
    session[:current_user] = "a Guest"
    redirect '/peeps'
  end

  get '/peeps' do
    @peeps = Peep.all
    @current_user = session[:current_user]
    erb :peeps
  end

  get '/add_peep' do
    erb :add_peep
  end

  post '/add_peep' do
    Peep.add(params[:new_peep], session[:current_user])
    redirect '/peeps'
  end
end
