class V1::PasswordsController < ApplicationController
  skip_before_action :authorize_request

  def forgot
    if params[:email].blank?
      return json_response({message: 'Provide a valid email'}, :bad_request)
    end

    user = User.find_by(email: params[:email])

    if user.present?
      user.generate_password_token!
      UserMailer.reset_password_email(user).deliver_now
      json_response({ message: 'An email has been sent to you' })
    else
      json_response(
        {message: 'This email does not exist. Please contact your administrator' },
        :bad_request
      )
    end
  end

  def reset
    token = params[:token].to_s

    if token.blank?
      json_response({ message: Message.missing_token }, :bad_request)
    end

    user = User.find_by(reset_password_token: token)

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        json_response({ message: 'Password set successfully' })
      else
        json_response({ message: user.errors.full_messages }, :unprocessable_entity)
      end
    else
      json_response(
        { message: 'Link not valid or expired. Try generating a new link.' },
        :not_found
      )
    end
  end
end
