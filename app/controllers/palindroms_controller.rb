# frozen_string_literal: true

# Palindroms controller
class PalindromsController < ApplicationController
  def index; end

  def result
    @number = params[:num].to_i
    @res_arr = PalindromsController.result_array(@number)
    redirect_to home_path, notice: 'Вводите числа >= 0' if @res_arr.size.zero?
  end

  def self.result_array(num)
    arr = (0..num).select do |elem|
      elem.to_s == elem.to_s.reverse && (elem**2).to_s == (elem**2).to_s.reverse
    end
    Array(arr)
  end
end