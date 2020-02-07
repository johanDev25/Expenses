class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    @type = Type.all
    @category = Category.all
    @expense = Expense.new

    @date = 30.days.ago.to_date
    @start_date = params[:start].try(:to_date)  || 1200.months.ago.to_date
    @end_date = params[:end].try(:to_date) || Date.current
    range = (@start_date..@end_date)

    if params[:category].present? && params[:type].present?
      @expenses = Expense.where("category_id = ? AND type_id = ?", "#{params[:category]}", "#{params[:type]}").where(date: range).order(date: :desc)
    elsif params[:category].present?
      @expenses = Expense.where("category_id = ?", "#{params[:category]}").where(date: range).order(date: :desc)
    elsif params[:type].present?
      @expenses = Expense.where("type_id = ?", "#{params[:type]}").where(date: range).order(date: :desc)
    else
      @expenses = Expense.all.where(date: range).order(date: :desc)
    end

    @total = @expenses.sum(:amount)
    @number = @expenses.count
    @average = @expenses.average(:amount)

  end

  def new
    @expense = Expense.new
  end

  def edit
  end

  def create
    @expense = Expense.new(expense_params)
      if @expense.save
       redirect_to expenses_url, notice: 'Expense was successfully created.'
    end
  end

  def update
      if @expense.update(expense_params)
       redirect_to expenses_url, notice: 'Expense was successfully updated.'
    end
  end

  def destroy
    @expense.destroy
    respond_to do |format|
      format.html { redirect_to expenses_url, notice: 'Expense was successfully destroyed.' }
    end
  end

  private
  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:date, :concept, :amount, :category_id, :type_id)
  end

end
