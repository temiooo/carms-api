class AuthenticateUser
  def initialize(school_id, password)
    @school_id = school_id
    @password = password
  end

  # Service entry point
  def call
    token = JsonWebToken.encode(user_id: user.id) if user

    return {
      user: { id: user.id, name: user.name, school_id: user.school_id },
      token: token
    }
  end

  private

  attr_reader :school_id, :password

  # verify user credentials
  def user
    user = User.find_by(school_id: school_id)
    return user if user && user.authenticate(password)

    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
