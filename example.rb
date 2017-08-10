# Require API
require_relative 'lib/api'
# Initialize API instance with page parameter (optional)
api = API.new(page: 1)
# Access results
api.spaces
# Navigate through pages
api.next_page
api.previous_page

# Access current page
api.current_page
# Access page size and total number of objects on page
api.page_size
api.total

# Sort by attributes. You can sort in descending order
api.sorted(:id, descending: true)
# Find similar spaces. Requires a numeric attribute and delta (defaults to 100)
space = api.spaces.first
api.find_similar(space, :daily_price, delta: 100)

# Print the results
puts api.spaces
