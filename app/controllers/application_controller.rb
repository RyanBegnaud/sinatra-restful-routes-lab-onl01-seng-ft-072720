class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do 
  end
  
  get '/recipes' do 
    @recipes = Recipe.all  
    erb :index 
  end

  post '/recipes' do 
    recipe = Recipe.create("name"=>"Enchiladas con Salsa Verde", "ingredients"=>"Tortillas, Queso Blanco, Tomatillos, Onion, Garlic, Black beans, Cilantro", "cook_time"=>"20 minutes")
    recipe.save 
    redirect to "/recipes/#{recipe.id}"
  end

  get '/recipes/new' do 
    erb :new
  end
  
  get '/recipes/:id' do 
    @recipe = Recipe.find(params[:id]) 
    erb :show
  end

  get '/recipes/:id/edit' do 
    @recipe = Recipe.find(params[:id])
    erb :edit 
  end

  patch '/recipes/:id' do
    Recipe.find(params[:id]).tap do |recipe|
      recipe.update(
        name: params[:name],
        ingredients: params[:ingredients],
        cook_time: params[:cook_time]
      )

      redirect "/recipes/#{recipe.id}"

    end
  end

  delete '/recipes/:id' do 
    Recipe.find(params[:id]).destroy
    redirect '/recipes'
  end
end
