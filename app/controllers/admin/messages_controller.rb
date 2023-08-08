class Admin::MessagesController < Admin::BaseController
  def index
    @messages = Message.order(created_at: :desc).page(params[:page]).per(10)
  end

  def destroy
    @message = load_message

    @message.destroy

    redirect_to admin_messages_path, notice: 'Дані видалено'
  end

  private

  def load_message
    Message.find(params[:id])
  end
end