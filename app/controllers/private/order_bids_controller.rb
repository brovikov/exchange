module Private
  class OrderBidsController < BaseController
    include Concerns::OrderCreation

    # before_action :gate_level1!, only: :create
    # before_action :gate_level2!, only: :create

    def create
      # binding.pry
      @order = OrderBid.new(order_params(:order_bid))
      order_submit
    end

    def clear
      @orders = OrderBid.where(member_id: current_user.id).with_state(:wait).with_currency(current_market)
      Ordering.new(@orders).cancel
      render status: 200, nothing: true
    end

  end
end
