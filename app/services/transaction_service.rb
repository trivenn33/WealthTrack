class TransactionService
  def self.process(portfolio, params)
    transaction = portfolio.transactions.new(params)

    return { success: false, errors: transaction.errors.full_messages } unless transaction.valid?

    ActiveRecord::Base.transaction do
      transaction.save!

      holding = portfolio.holdings.find_or_initialize_by(symbol: transaction.symbol)

      if transaction.transaction_type == "buy"
        total_cost = (holding.quantity || 0) * (holding.average_price || 0)
        new_cost = transaction.quantity * transaction.price

        new_quantity = (holding.quantity || 0) + transaction.quantity
        new_avg_price = (total_cost + new_cost) / new_quantity

        holding.quantity = new_quantity
        holding.average_price = new_avg_price
      else
        raise "Insufficient shares" if holding.quantity.to_i < transaction.quantity

        holding.quantity -= transaction.quantity
      end

      holding.save!
    end

    { success: true, transaction: transaction }
  rescue => e
    { success: false, errors: [e.message] }
  end
end