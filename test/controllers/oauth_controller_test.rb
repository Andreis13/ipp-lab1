require 'test_helper'
require 'json'

class OauthControllerTest < ActionController::TestCase
  def setup
    @controller = OauthController.new
  end

  test "register" do
    assert (accounts_count = Account.count)
    post :register, { email: 'email', password: '12345', app_id: App.first.id, format: 'json' }
    assert_equal(accounts_count + 1, Account.count)

    assert_equal({ "code" => 0, "token" => Token.last.token }, JSON.parse(@response.body))
  end

  test "register existing user" do
    a = Account.first
    post :register, { email: a.email, password: a.password, app_id: App.first.id, format: 'json' }

    assert_equal({ "code" => 1 }, JSON.parse(@response.body))
  end

  test "login" do
    a = Account.first
    app = App.first
    ts = Token.count
    Timecop.freeze do
      post :login, { email: a.email, password: a.password, app_id: app.id, format: 'json' }
      assert_equal(ts + 1, Token.count)
      t = Token.last
      assert_equal app.id, t.app_id
      assert_equal a.id, t.account_id
      assert_equal Time.now.to_i, t.created_at.to_i
    end

    assert_equal({ "code" => 0, "token" => Token.last.token }, JSON.parse(@response.body))
  end

  test "login with wrong credentials" do
    post :login, { email: 'bademail', password: 'badpassword', app_id: App.first.id, format: 'json' }
    assert_equal({ "code" => 2 }, JSON.parse(@response.body))
  end

  test "last login" do
    t = Time.local(2015, 1, 1, 12, 0, 0)
    a = Account.first

    Timecop.travel(t) do
      post :login, { email: a.email, password: a.password, app_id: App.first.id, format: 'json' }
    end

    Timecop.travel(Time.local(2015, 10, 10, 22, 0, 0)) do
      get :last_login, { email: a.email, app_id: App.first.id, token: Token.last.token, format: 'json' }
      assert_equal({ "code" => 0, "time" => t.to_i }, JSON.parse(@response.body))
    end
  end
end
