class Api::V1::UsersController < Api::V1::BaseController
  before_action :authenticate_user!, only: [:update]

  def show
    @user = User.find(params[:id])

    # 原文使用 Api::V1::UserSerializer
    # 我們現在使用 app/views/api/v1/users/show.json.jbuilder
    # render(json: Api::V1::UserSerializer.new(user).to_json)
  end

  # curl -i -X PUT -d "user[name]=gg-user" \
  # --header "Authorization: Token token=Xm9JzRgY3CSBD+SpBtE5UO3Dn59FB54CzBBEazB4Us5RpVBLWHDusISdP9j1iBOlRw9VSX8t1zNp/1dzmg3mqA==, \
  # email=test-user-00@mail.com" \
  # http://localhost:3000//api/v1/users/2

  def update
    @user = User.find(params[:id])
    # return api_error(status: 403) if !UserPolicy.new(current_user, @user).update?
    authorize @user, :update?
    @user.update_attributes(update_params)
  end

  private

  def update_params
    params.require(:user).permit(:name)
  end
end
