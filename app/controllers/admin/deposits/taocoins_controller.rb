module Admin
  module Deposits
    class TaocoinsController < ::Admin::Deposits::BaseController
      load_and_authorize_resource :class => '::Deposits::Taocoin'

      def index
        start_at = DateTime.now.ago(60 * 60 * 24 * 365)
        @taocoins = @taocoins.includes(:member).
          where('created_at > ?', start_at).
          order('id DESC').page(params[:page]).per(200)
      end

      def update
        @taocoin.accept! if @taocoin.may_accept?
        redirect_to :back, notice: t('.notice')
      end
    end
  end
end
