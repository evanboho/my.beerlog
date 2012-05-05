module ApplicationHelper
  
  def hero
    if controller_name == "registrations"
      return ["sign up", "create an account"] if action_name == "new"
    end
    if controller_name == "sessions"
      return ["log in", "welcome back"] if action_name == "new" 
    end 
    return ["b(eer)log", "accounting for taste"]
  end
  
  def sortable(column, title = nil)
    title ||= column
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to title, params.merge(:sort => column, :direction => direction, :page => nil), { :class => css_class }
  end
  
end
