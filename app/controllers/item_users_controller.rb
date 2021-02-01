class ItemUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :seller_user, only: [:index]
  before_action :item_params, only: [:index, :create]

  def index
    @item_user_buyer = ItemUserBuyer.new
    if @item.item_user.nil?
      render :index
    else
      redirect_to root_path
    end
  end

  def create
    if @item_user_buyer.valid?
      pay_item
      @item_user_buyer.save
      redirect_to root_path
    else
      render action: :index
    end
    @item_user_buyer = ItemUserBuyer.new(buyer_params)
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

  def seller_user
    redirect_to root_path if current_user == @item_user_id || @item_user.present?
  end
end
