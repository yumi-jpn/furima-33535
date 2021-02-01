class ItemUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :item_params, only: [:index, :create]

  def index
    @item_user_buyer = ItemUserBuyer.new
    if @item.item_user.nil? && current_user.id != @item.user.id
      render :index
    elsif current_user != @item.user.id
      redirect_to root_path
    end
  end

  def create
    @item_user_buyer = ItemUserBuyer.new(buyer_params)
    if @item_user_buyer.valid?
      pay_item
      @item_user_buyer.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private

  def item_params
    @item = Item.find(params[:item_id])
  end

  def buyer_params
    params.require(:item_user_buyer).permit(:postal_code, :ship_area_id, :municipalities,
                                            :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: buyer_params[:token],
      currency: 'jpy'
    )
  end
end
