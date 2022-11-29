# frozen_string_literal: true

# Palindroms controller
class PalindromsController < ApplicationController
  before_action :set_num, only: :result
  before_action :valid_value, only: :result

  def index; end

  def result
    add_to_database(@number)
    @note = Palindrom.find_by(num: @number)
    @res_arr = @note[:result].split.map(&:to_i)
    @squares = @note[:squares].split.map(&:to_i)
    @hash = Hash[@res_arr.zip @squares]
  end

  def check_page; end

  def check_exists
    @check_par = params[:check].to_i
    @check_note = Palindrom.find_by(num: @check_par)
    if @check_note.nil?
      redirect_to check_path, error: 'Нет в базе данных'
    else
      @check_arr = @check_note[:result].split.map(&:to_i)
    end
  end

  def check_data_xml
    @notes = Palindrom.all.map(&:to_xml)
  end

  private

  def set_num
    @number = params[:num].to_i
  end

  def valid_value
    redirect_to home_path, notice: 'Вводите числа >= 0' if @number.negative?
  end

  def result_array(num)
    arr = (0..num).select do |elem|
      elem.to_s == elem.to_s.reverse && (elem**2).to_s == (elem**2).to_s.reverse
    end
    Array(arr)
  end

  def add_to_database(number)
    return unless Palindrom.find_by(num: number).nil?

    row = []
    row << { num: number.to_i, result: result_array(number).join(' '), count: result_array(number).size,
             squares: result_array(number).map { |el| el**2 }.join(' ') }
    Palindrom.insert_all(row)
    flash[:alert] = 'Данные добавлены в базу данных'
  end
end
