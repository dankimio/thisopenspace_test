# Require API
require_relative 'lib/api'
# Initialize API instance with page parameter (optional)
api = API.new(page: 1)
# Navigate through pages
api.next_page
api.previous_page
# Sort by attributes. You can sort in descending order
api.sorted(:id, descending: true)
# Access current page
api.current_page
# Access page size and total number of objects on page
api.page_size
api.total
# Print the results
puts api.spaces
