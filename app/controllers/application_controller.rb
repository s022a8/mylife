class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?


    #deviseのリダイレクト先変更
    def after_sign_up_path(resource)
        root_path
    end
    
    def after_sign_in_path_for(resource)
        case resource
        when User
            root_path
        when Admin
            admin_path
        end
    end

    def after_sign_out_path_for(resource)
        if resource == :user
            root_path
        else
            new_admin_session_path
        end
    end



    protected 

        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
            devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile_image])
        end
end
