class RegistrationsController < Devise::RegistrationsController

    
    private

    

    def after_sign_up_path_for(resource)
        root_path # or any other path
    end
    def after_registration_path(resource)
        root_path
    end
        

    def sign_up_params
        params.require(:user).permit(:name,:username, :email, :password, :password_confirmation,:remember_me, :avatar, :avatar_cache)
    end
    def acount_update_params
        params.require(:user).permit(:name,:username, :email, :password, :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar)
    end
    def update_resource(resource, params)
        # Require current password if user is trying to change password.
        return super if params["password"]&.present?
    
        # Allows user to update registration information without password.
        resource.update_without_password(params.except("current_password"))
    end

    
end