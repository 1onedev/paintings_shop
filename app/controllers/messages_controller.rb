class MessagesController < BaseController
  layout false

  def create
    Message.create!(message_params)
  end

  private

  def message_params
    params.require(:message).permit(:name, :email, :subject, :text)
  end
end
