class Api::V1::ExpensesController < ApplicationController
  def index
    @expenses = Expense.all
    render json: @expenses, status: :ok
  end

  def create
		@expense = Expense.create( expenses_params)

		if @expense.save
			render json: @expense, status: 201
		else
			render json: { errors: @expense.errors }, status: 422
		end
	end

  def update
  @expense = Expense.find(params[:id])
  if @expense.update( expenses_params)
    render json: @expense, status: 200
  else
    render json: { errors: @expense.errors }, status: 422
  end
end

def destroy
  @expense = Expense.find(params[:id])
  @expense.destroy

  head 204
end

  private
  def expenses_params
   params.require(:expense).permit(:date, :concept, :amount, :category_id, :type_id)
  end
end
