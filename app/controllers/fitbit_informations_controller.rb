class FitbitInformationsController < ApplicationController
  def create
    if current_user.fitbit_information
      update_current_information_for_user
    else
      create_fitbit_information_for_user
    end

    redirect_to root_path
  end

  protected

  def create_fitbit_information_for_user
    current_user.create_fitbit_information(
      oauth_token: auth_hash.credentials.token,
      oauth_secret: auth_hash.credentials.secret
    )
    current_user.create_weight_loss_information
    StatUpdater.new(current_user).update_stats
  end

  def update_current_information_for_user
    current_user.fitbit_information.update_attributes(
      oauth_token: auth_hash.credentials.token,
      oauth_secret: auth_hash.credentials.secret
    )
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end
