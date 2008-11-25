require "test/unit"
require "fileutils"
require File.dirname(__FILE__) + "/../lib/rwget"

class FetchTest < Test::Unit::TestCase
  include FileUtils
  
  def setup
    @tmp = File.dirname(__FILE__) + "/tmp"
    mkdir_p @tmp
    @store = RWGet::Store.new(@tmp)
  end
  
  def teardown
    rm_rf @tmp
  end
  
  def test_put
    file = Tempfile.new("testing")
    file.puts "hello"
    file.close
    @store.put("foo/bar", file)
    new_path = File.join(@tmp, "foo/bar")
    assert File.exists?(new_path)
    assert File.read(new_path) =~ /hello/
  end
end