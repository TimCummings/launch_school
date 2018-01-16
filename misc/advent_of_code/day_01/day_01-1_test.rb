# day_01-1_test.rb

require 'minitest/autorun'
# require 'minitest/reporters'
# Minitest::Reporters.use!
require_relative 'day_01-1'

class CaptchaTest < Minitest::Test
  def test_solve
    captcha1 = Captcha.new('1122')
    assert_equal 3, captcha1.solve

    captcha2 = Captcha.new('1111')
    assert_equal 4, captcha2.solve

    captcha3 = Captcha.new('1234')
    assert_equal 0, captcha3.solve

    captcha4 = Captcha.new('91212129')
    assert_equal 9, captcha4.solve
  end
end
