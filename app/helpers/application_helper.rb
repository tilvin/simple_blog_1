module ApplicationHelper
  def show_errors(errors, field)
    return if errors[field].empty?

    content_tag :p, class: 'field_with_errors' do
      concat(errors[field].join(', '))
    end
  end
end
