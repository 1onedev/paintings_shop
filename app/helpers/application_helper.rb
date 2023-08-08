module ApplicationHelper
  def truncate_markup(text, length = 30, omission = '...', separator = ' ')
    return if text.blank?

    truncate(strip_tags(text).strip, length: length, omission: omission, separator: separator)
  end
  
  def price_format(price)
    number_to_currency price, precision: 2, unit: "$", strip_insignificant_zeros: true, locale: :ua, format: '%u%n'
  end 

  def count_format(count)
    number_to_currency count, precision: 2, unit: "#{t 'count_sign'}", strip_insignificant_zeros: true, locale: :ua, format: '%n %u'
  end

  def availabilities_tag(resource)
    if resource.sold?
      content_tag(:span, "#{t 'enums.sold'}", class: 'ribbon out-of-stock')
    else
    end  
  end

  def published_tag(resource)
    if resource.published?
      content_tag(:span, "#{t 'enums.published'}", class: 'badge badge-pill badge-success')
    else
      content_tag(:span, "#{t 'enums.hide'}", class: 'badge badge-pill badge-danger')
    end
  end

  def page_entries_info(resource)
    content_tag :p, :class => "result-count" do
      resource_name = resource.klass.name.downcase.pluralize
      if resource.count > 0
        "#{t 'showed'} #{resource.offset_value + 1} - #{resource.offset_value + resource.length} #{t 'from'} #{resource.total_count}"
      end
    end
  end
end
