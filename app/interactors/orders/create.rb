module Orders
  class Create
    include Interactor
    delegate :params, :password, to: :context # in
    delegate :order, to: :context # out

    before { normalize_params }

    def call
      ActiveRecord::Base.transaction do
        context.order = Order.new(params)
        order.save!
        order.reload
        order.update!(
          number: order.id + 1000,
          uid: Base64.urlsafe_encode64([order.id, order.created_at.to_i].join)
        )
    end

    rescue StandardError => e
      context.fail! error: e
    end

    private

    def normalize_params
      params[:phone] = params[:phone]&.strip
      params[:name] = params[:name]&.strip
      params[:surname] = params[:surname]&.strip
    end
  end
end
