module Api
  module V1
    class HoldingsController < ApplicationController
      def index
        holdings = current_user.portfolios.find(params[:portfolio_id]).holdings
        render json: holdings
      end

      def create
        portfolio = current_user.portfolios.find(params[:portfolio_id])

        holding = portfolio.holdings.new(holding_params)

        if holding.save
          render json: holding, status: :created
        else
          render json: { errors: holding.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def holding_params
        params.permit(:symbol, :quantity, :average_price)
      end
    end
  end
end