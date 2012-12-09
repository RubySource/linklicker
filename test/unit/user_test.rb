require 'test_helper'

class UserTest < ActiveSupport::TestCase

  should have_many(:links)
  should have_many(:licked_links)
end
