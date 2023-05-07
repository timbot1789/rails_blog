class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    http_basic_authenticate_with( 
        name: ENV["ADMIN_USER"], 
        password: ENV["ADMIN_PASSWORD"], 
        except: [:show, :index, :prompt]
    )
end
