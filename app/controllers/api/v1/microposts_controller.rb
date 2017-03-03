class Api::V1::MicropostsController <  Api::V1::BaseController
  # curl -i -X GET http://localhost:3000/api/v1/user/1/microposts.json?per_page=3
  def index
    user = User.find(params[:user_id])
    @microposts = paginate(user.microposts)
  end
end
