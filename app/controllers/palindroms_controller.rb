# frozen_string_literal: true

# Palindroms controller
class PalindromsController < ApplicationController
  include PalindromsHelper
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
      flash[:info] = 'Есть в базе данных'
      @check_arr = @check_note[:result].split.map(&:to_i)
      @check_sqr = @check_note[:squares].split.map(&:to_i)
      @check_hash = Hash[@check_arr.zip @check_sqr]
    end
  end

  def check_data_xml
    render xml: Palindrom.all
  end

  private

  def add_to_database(number)
    return flash[:warning] = 'Уже есть в базе данных' unless Palindrom.find_by(num: number).nil?

    row = []
    row << { num: number.to_i, result: PalindromsHelper.result_array(number).join(' '),
             count: PalindromsHelper.result_array(number).size,
             squares: PalindromsHelper.result_array(number).map { |el| el**2 }.join(' ') }
    Palindrom.insert_all(row)
    flash[:alert] = 'Данные добавлены в базу данных'
  end
end
