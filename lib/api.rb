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
    @spaces = parse_response
  end

  def next_page
    @current_page += 1
    make_request
    parse_response
  end

  def previous_page
    return [] if @current_page == 1

    @current_page -= 1
    make_request
    parse_response
  end

  # Returns all spaces sorted by given attribute
  def sorted(attribute_name, descending: false)
    spaces = all_spaces

    # Select spaces with non-nil values
    result = spaces.select { |space| !space.send(attribute_name).nil? }
      .sort_by { |space| space.send(attribute_name) }
    result.reverse! if descending

    result
  end

  def find_similar(current_space, attribute_name, delta: 100)
    spaces = all_spaces

    result = spaces
      .select { |space| !space.send(attribute_name).nil? }
      .select do |space|
        (space.send(attribute_name) - current_space.send(attribute_name)).abs < delta
      end

      result
  end

  # Get spaces from all pages
  def all_spaces
    # Reset attributes
    temp_page = @current_page
    @spaces = []
    @current_page = 1
    # Pull data from all pages
    make_request
    while @response != nil
      @spaces += parse_response
      next_page
    end
    # Return spaces and reset current page number
    @current_page = temp_page
    @spaces
  end

  private

  # URL with page parameter
  def spaces_url
    BASE_URL + "?page=#{@current_page}"
  end

  # Performs request and updates instance data
  def make_request
    response = HTTParty.get(spaces_url, format: :json)
    @response = response.success? ? response : nil
  rescue
    @response = nil
  end

  # Parses response and returnes spaces
  def parse_response
    @page_size = @response['page_size']
    @total = @response['total']

    @response['data'].map { |space| Space.new(space) }
  rescue
    []
  end
end
