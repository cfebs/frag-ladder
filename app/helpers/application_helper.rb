module ApplicationHelper
  def errors_for obj
    render 'shared/errors', :obj => obj
  end
end
