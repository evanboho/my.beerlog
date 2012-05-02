class AuthenticationsController < ApplicationController
  
  def create
    info = request.env['omniauth.auth'].extra.raw_info
    auth = request.env['omniauth.auth'].except('extra')
    # render :text => auth['info']
     authentication = Authentication.find_by_provider_and_uid(auth.provider, auth.uid)
     if authentication
       flash[:notice] = "signed in!"
       sign_in_and_redirect(:user, authentication.user)
     elsif current_user
       authentication = Authentication.new
       current_user.authentications.create!(:provider => auth.provider, :uid => auth.uid, :nickname => auth['info'].nickname)
       flash[:notice] = "connected!"
       redirect_to current_user
     elsif user = User.find_by_email(auth['info'].email)
       user.authentications.create!(:provider => auth.provider, :uid => auth.uid)
       flash[:notice] = "found and connected!"
       sign_in_and_redirect(:user, user)
     else
       user = User.new(:firstname => auth['info'].name.split.first, :lastname => auth['info'].name.split.last, 
                       :email => auth['info'].email, :password => Devise.friendly_token[0,20])
       if user.save
          user.build_auth(auth)
          flash[:notice] = "created, connected and signed in!"
          sign_in_and_redirect(:user, user)
        else
          flash[:warning] = "Sorry! We didn't get an email. Please try another method."
          # session['devise.omniauth'] = auth
          redirect_to sign_up_path
        end
     end
  end
  
end
