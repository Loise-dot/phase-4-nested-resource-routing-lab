class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    items = Item.all
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    item = Item.find(params[:id])
    render json: item, include: :user
  end

  def create
    user = User.find(params[:user_id])
    item = user.items.create(name: params[:name], description: params[:description], price: params[:price], user_id: params[:user_id])
    render json: item, status: :created
  end

  def render_not_found_response
    render json: { error: "User not found" }, status: :not_found
  end


end

