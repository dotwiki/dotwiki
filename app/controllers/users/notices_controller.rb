class Users::NoticesController < ApplicationController
  def index
    gon.current_user = current_user.id
    gon.notices = current_user.notices.value
  end

  def destroy
    s = current_user.notices.slice(params[:id])
    current_user.notices.delete(s)
    render body: nil, status: 200
  end

  def reflesh
    s = current_user.notices.slice(params[:id])
    current_user.notices.delete(s)
    render body: nil, status: 200
  end
end
