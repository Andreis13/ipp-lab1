class OauthController < ApplicationController

  def register
    unless email && password
      render json: { code: 2 }
      return
    end

    unless app_id && App.where(id: app_id).first
      render json: { code: 4 }
      return
    end

    if Account.where(email: email).first
      render json: { code: 1 }
      return
    end

    a = Account.create!(email: email, password: password)
    t = Token.create(account_id: a.id, app_id: app_id)
    render json: { code: 0, token: t.token }
  end

  def login
    unless app_id && App.where(id: app_id).first
      render json: { code: 4 }
      return
    end

    unless email && password
      render json: { code: 2 }
      return
    end

    if a = Account.where(email: email, password: password).first
      t = Token.create(account_id: a.id, app_id: app_id)
      render json: { code: 0, token: t.token }
    else
      render json: { code: 2 }
    end
  end

  def last_login
    unless token
      render json: { code: 3 }
      return
    end

    a = Account.find_by!(email: email)
    if t = a.tokens.where(token: token, app_id: app_id).last
      render json: { code: 0, time: t.created_at.to_i }
    else
      render json: { code: 5 }
    end
  end



  private

  %w(email password app_id token).each do |m|
    define_method m do
      params[m]
    end
  end
end
