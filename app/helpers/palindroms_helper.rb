# frozen_string_literal: true

# helping me
module PalindromsHelper
  def set_num
    @number = params[:num].to_i
  end

  def valid_value
    redirect_to home_path, notice: 'Вводите числа >= 0' if @number.negative?
  end

  def self.result_array(num)
    arr = (0..num).select do |elem|
      elem.to_s == elem.to_s.reverse && (elem**2).to_s == (elem**2).to_s.reverse
    end
    Array(arr)
  end
end
