module ApplicationHelper
  def errors_for obj
    render 'shared/errors', :obj => obj
  end

  def percentage n, d
    if d.zero?
      return number_to_percentage(0)
    end

    number_to_percentage( (n.to_f / d.to_f) * 100, :precision => 1 )
  end
end
