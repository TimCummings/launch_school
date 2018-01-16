# day_01-2_test.rb

require 'minitest/autorun'
# require 'minitest/reporters'
# Minitest::Reporters.use!
require_relative 'day_01-2'

class CaptchaTest < Minitest::Test
  def test_solve
    captcha1 = Captcha.new('1212')
    assert_equal 6, captcha1.solve

    captcha2 = Captcha.new('1221')
    assert_equal 0, captcha2.solve

    captcha3 = Captcha.new('123425')
    assert_equal 4, captcha3.solve

    captcha4 = Captcha.new('123123')
    assert_equal 12, captcha4.solve

    captcha5 = Captcha.new('12131415')
    assert_equal 4, captcha5.solve
  end
end
