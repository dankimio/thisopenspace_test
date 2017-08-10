class Space
  attr_reader :id, :name, :address,
                :hourly_price, :daily_price,
                :square_footage, :capacity,
                :views_count, :primary_photo_css_url_small

  def initialize(attributes)
    attributes.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end
end
