module UserHelper
  
  def username(user)
    name = user.email.split('.')[0]
    
    link_to name + '_' + user.id.to_s, user_path(user)
  end  
  
end
