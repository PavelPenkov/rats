require "test_helper"

class RatsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Rats::VERSION
  end
end
