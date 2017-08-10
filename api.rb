require 'httparty'
require_relative 'space'

# Usage:
# api = API.new(page: 1)
# api.spaces
# api.next_page
class API
  BASE_URL = 'https://thisopenspace.com/lhl-test'

  attr_reader :spaces
  attr_reader :current_page
  attr_reader :page_size, :total

  def initialize(page: 1)
    @current_page = page

    make_request
  end

  def next_page
    @current_page += 1
    make_request
    spaces
  end

  def previous_page
    return [] if @current_page == 1

    @current_page -= 1
    make_request
    spaces
  end

  private

  # URL with page parameter
  def spaces_url
    BASE_URL + "?page=#{@current_page}"
  end

  # Performs request and update instance data
  def make_request
    response = HTTParty.get(spaces_url, format: :json)

    @spaces = response['data'].map { |space| Space.new(space) }
    @page_size = response['page_size']
    @total = response['total']
  rescue
    @spaces = []
  end
end
