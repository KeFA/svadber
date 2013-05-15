module ApplicationHelper
  def current_wedding
    current_user.wedding
  end

  def sortable(column_name, title)
    order = column_name == params[:sort] && params[:order] == 'asc' ? 'desc' : 'asc'
    css_class = column_name == params[:sort] ? "current #{params[:order]}" : nil
    link_to title, { sort: column_name, order: order }, class: css_class
  end
end
