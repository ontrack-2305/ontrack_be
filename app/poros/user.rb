class User
  attr_reader :id,
              :google_id,
              :token,
              :email

  def initialize(params)
    @id = params[:user_id]
    @google_id = params[:google_id]
    @token = params[:access_token]
    @email = params[:email]
  end
end