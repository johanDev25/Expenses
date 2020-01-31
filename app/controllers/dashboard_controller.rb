class DashboardController < ApplicationController
  def index
    @tab = :dashboard

    @expenses = Expense.all
    @types = Type.all
    @categories = Category.all

    last_month_chart = {}
    this_month_chart = {}

    @last_months = []
    @by_day = []
    @by_category = {}
    @accumulated = []

    @today = Expense.where("date = ?", Date.current).sum(:amount)
    @yesterday = Expense.where("date = ?", Date.yesterday).sum(:amount)
    @this_month = Expense.where("date >= ? AND date <= ?", Date.today.at_beginning_of_month, Date.today.at_end_of_month).sum(:amount)
    @last_month = Expense.where("date >= ? AND date <= ?", Date.today.at_beginning_of_month.last_month, Date.today.at_end_of_month.last_month).sum(:amount)

    @types.each do |type|

    @last_months << { name: type.body.capitalize , data: Expense.where("type_id = #{type.id}").group_by_month(:date, last: 6).sum(:amount) }

    @by_day << { name: type.body.capitalize , data: Expense.where("date >= ? AND date <= ? AND type_id = #{type.id}", Date.today.at_beginning_of_month, Date.today.at_end_of_month).group_by_day_of_month(:date).sum(:amount) }

    last_month_chart[type.body] = Expense.where("date >= ? AND date <= ? AND type_id = #{type.id}", Date.today.at_beginning_of_month.last_month, Date.today.at_end_of_month.last_month).sum(:amount)
    this_month_chart[type.body] = Expense.where("date >= ? AND date <= ? AND type_id = #{type.id}", Date.today.at_beginning_of_month, Date.today.at_end_of_month).sum(:amount)
    end

    @categories.each do |category|
    @by_category[category.body] = Expense.where("category_id = #{category.id}").sum(:amount)
    end

    @accumulated = [{ name: 'This Month', data: this_month_chart }, { name: 'Last Month', data: last_month_chart }]
  end
end
