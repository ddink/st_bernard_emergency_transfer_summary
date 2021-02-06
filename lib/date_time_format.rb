module DateTimeFormat
  def formatted_date
    moment.time.strftime("%B %-d, %Y")
  end

  def formatted_time
    moment.time.strftime("%I:%M %p").downcase
  end
end