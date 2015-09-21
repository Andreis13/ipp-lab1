require 'test_helper'

class RoutesTest < ActionDispatch::IntegrationTest
  test "routes" do
    assert_generates 'oauth/register', { controller: 'oauth', action: 'register' }
    assert_generates 'oauth/login', { controller: 'oauth', action: 'login' }
    assert_generates 'oauth/last_login', { controller: 'oauth', action: 'last_login' }
  end
end
