class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session
    http_basic_authenticate_with( 
        name: "admin", 
        password: "starsector2022", 
        except: [:show, :index]
    )
end
