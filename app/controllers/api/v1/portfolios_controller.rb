module Api
  module V1
    class PortfoliosController < ApplicationController
      def create
        portfolio = current_user.portfolios.new(portfolio_params)

        if portfolio.save
          render json: portfolio, status: :created
        else
          render json: { errors: portfolio.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def index
        portfolios = current_user.portfolios
        render json: portfolios
      end

      private

      def portfolio_params
        params.permit(:name)
      end
    end
  end
end