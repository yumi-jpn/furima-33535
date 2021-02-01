class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :item_paramas, only: [:show, :edit, :update, :destroy]
  before_action :ensure_user, only: [:edit, :update]
  # before_action :sold_out_method, only: [:edit, :update, :destroy]

  def index
    @items = Item.all.order(created_at: :desc)
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

  def show
  end

  def edit
    if @item.item_user.nil?
      render :edit
    else
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    if @item.user_id == current_user.id
      @item.destroy
      redirect_to root_path
    end
  end

  private

  def item_paramas
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:image, :item_name, :explanation, :category_id, :state_id, :ship_method_id, :ship_area_id,
                                 :ship_date_id, :price, user_ids: []).merge(user_id: current_user.id)
  end

  def ensure_user
    @items = @item.user_id == current_user.id
    redirect_to root_path unless @items
  end

  # def sold_out_method
  #   unless @item.item_user.nil?
  #     redirect_to root_path unless @item_user
  #   else
  #     render :index
  #   end
  # end
end
