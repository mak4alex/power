module ApplicationHelper
  @@flash_types = HashWithIndifferentAccess.new(
    {
      success: 'alert-success', 
      error: 'alert-danger', 
      alert: 'alert-warning', 
      notice: 'alert-info'
    })
  
  def bootstrap_class_for(flash_type)
    @@flash_types[flash_type] || flash_type
  end

  def flash_messages
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type.to_s)} fade in") do 
        concat content_tag(:button, '&times;'.html_safe, class: "close", data: { dismiss: 'alert' })
        concat message 
      end)
    end
    nil
  end
  
  def id(record)
    "id=#{record.class.name.downcase}-#{record.id}"
  end
  
end
