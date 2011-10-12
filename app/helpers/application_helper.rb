module ApplicationHelper

#  helper_method :filter_link

  def filter_link(params, text, field, value, login = false)
    if login and !current_user
      link_to text, login_url, :class => 'filter_link'
    elsif not params[field].to_s.eql? value.to_s
      link_to text, params.merge(field => value), :class => 'filter_link'
    else
      content_tag :span, :class => 'filter_link_active' do
        content_tag(:b, text)
      end
    end
  end

  def filter_link_type(params, text, value)
    if not params[:controller].to_s.eql? value.to_s
      link_to text, params.merge(:controller => value), :class => 'filter_link'
    else
      content_tag :span, :class => 'filter_link_active' do
        content_tag(:b, text)
      end
    end
  end


  # absolute
  def navigation_link(params, link, options)
    selected = (options.size > 0)
    options.each do |k, v|
      selected = false if (params[k].to_s != v.to_s)
    end

    link_to_square(selected, link)
  end

  def navigation_link_filter(params, link, filter)
    selected =
        case filter
          when 'profile'
            params[:controller].to_s == 'twins' and params[:action].to_s == 'profile'
          when 'movies'
            params[:controller].to_s == 'movies'
          when 'twins'
            params[:controller].to_s == 'twins' and params[:action].to_s != 'profile'
          when 'lists'
            params[:controller].to_s == 'movie_lists'
          when 'genres'
            params[:controller].to_s == 'genres'
        end
    link_to_square(selected, link)
  end

  def link_to_square(selected, link)
    link_to link do
      content_tag(:div, "", :id =>"profile button", :class => "menu_button #{'menu_button_selected' if selected}")
    end
  end

  def title(title)
    content_for(:title, title)
  end

  def description(description)
    content_for(:description, description)
  end

  def keywords(keywords)
    content_for(:keywords, keywords)
  end

end 
