class Admin::AnswersController < Admin::BaseController
  def index 
    @answers = Answer.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @answer = load_answer
  end

  def new
    @answer = Answer.new
  end

  def edit
    @answer = load_answer
  end

  def create
    @answer = Answer.new(answer_params)

    if @answer.save
      redirect_to admin_answer_path(@answer), notice: 'Дані збережено'
    else
      flash[:alert] = "Помилка: #{@answer.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def update
    @answer = load_answer

    if @answer.update(answer_params)
      redirect_to admin_answer_path(@answer), notice: 'Дані збережено'
    else
      flash[:alert] = "Помилка: #{@answer.errors.full_messages.join(', ')}"

      render :edit
    end
  end

  def destroy
    @answer = load_answer

    @answer.destroy

    redirect_to admin_answers_path, notice: 'Дані видалено'
  end

  private

  def load_answer
    Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(
      :question,
      :question_en,
      :text,
      :text_en
    )
  end
end