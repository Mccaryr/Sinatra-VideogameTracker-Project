class UserController < ApplicationController 



    get '/signup' do 
        if !logged_in? 
        erb :"/users/create_user"
        else 
            redirect '/videogames'
        end 
    end
    
    post '/signup' do 

            user=User.new(params)
            if user.save 
                session[:user_id]=user.id
                redirect '/videogames'
            else 
                redirect '/signup'
            end 
    end 

    get '/login' do    
        if !logged_in? 
            erb :"/users/login"
        else 
        redirect '/videogames'
        end 
    end
    
    post '/login' do 
        @user=User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            session[:user_id]= @user.id 
            redirect '/videogames'
        else 
            redirect '/signup'
             
        end 
    end 

    get '/logout' do 
        if logged_in? 
            session.destroy 
            redirect '/login'
        else 
            redirect '/'
        end 
    end 
end 