require 'test_helper'

class LinkTest < ActiveSupport::TestCase
 
  should belong_to(:user)
  should validate_presence_of(:url)

end
