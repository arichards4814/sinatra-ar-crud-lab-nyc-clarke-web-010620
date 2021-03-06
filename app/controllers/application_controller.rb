
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles/new' do

    erb :new
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  post '/articles' do
    article = Article.create(params)
  
    redirect to "/articles/#{article.id}"
  end

  get '/articles/:id' do
      @article = Article.find(params[:id])
      erb :show
  end

  get '/articles/:id/edit' do
      @article = Article.find(params[:id])
      erb :edit
  end

  patch '/articles/:id' do
    new_params = {}
    new_params[:title] = params[:title]
    new_params[:content] = params[:content]
    @article = Article.find(params[:id])

    @article.update(new_params)

    redirect to "/articles/#{@article.id}"
  end


  delete '/articles/:id' do
    @article = Article.destroy(params[:id])
    
    redirect to "/articles"
  end

end
