class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :edit, :update, :destroy]

  def index
    @type = Type.all
    @category = Category.all
    @expense = Expense.new

    if params[:category].present? && params[:type].present?
      @expenses = Expense.where("category_id = ? AND type_id = ?", "#{params[:category]}", "#{params[:type]}").order("date DESC")
    elsif params[:category].present?
      @expenses = Expense.where("category_id = ?", "#{params[:category]}").order("date DESC")
    elsif params[:type].present?
      @expenses = Expense.where("type_id = ?", "#{params[:type]}").order("date DESC")
    else
      @expenses = Expense.all
    end
    @total = @expenses.sum(:amount)
  end

  def show
  end

  def new
    @expense = Expense.new
  end

  def edit
  end

  def create
    @expense = Expense.new(expense_params)

    respond_to do |format|
      if @expense.save
        format.html { redirect_to expenses_url, notice: 'Expense was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expenses_url, notice: 'Expense was successfully updated.' }
      else
        format.html { render :edit }
      end
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
