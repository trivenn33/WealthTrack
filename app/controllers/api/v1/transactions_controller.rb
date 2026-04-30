module Api
  module V1
    class TransactionsController < ApplicationController
      def create
        portfolio = current_user.portfolios.find(params[:portfolio_id])

        result = TransactionService.process(portfolio, transaction_params)

        if result[:success]
          render json: result[:transaction], status: :created
        else
          render json: { errors: result[:errors] }, status: :unprocessable_entity
        end
      end

      private

      def transaction_params
        params.permit(:symbol, :transaction_type, :quantity, :price)
      end
    end
  end
end