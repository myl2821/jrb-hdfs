require 'test_helper'

class Jrb::HdfsTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Jrb::Hdfs::VERSION
  end
end
