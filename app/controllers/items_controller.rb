class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    # @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :item_name, :explanation, :category_id, :state_id, :ship_method_id, :ship_area_id,
                                 :ship_date_id, :price, user_ids: []).merge(user_id: current_user.id)
  end
end
