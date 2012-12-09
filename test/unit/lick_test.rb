require 'test_helper'

class LickTest < ActiveSupport::TestCase
  should belong_to(:user)
  should belong_to(:link)
end
