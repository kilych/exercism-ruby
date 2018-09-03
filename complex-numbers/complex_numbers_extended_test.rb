require_relative 'complex_numbers_test'
# OR:
# require 'minitest/autorun'
# require_relative 'complex_numbers'
# run multiple tests:
# $ for file in complex_numbers/*.rb; do ruby -I lib -r disable_skip -r minitest/pride $file; done 

require 'matrix'

class ComplexNumberExtendedTest < Minitest::Test
  def test_magnitude_of_a_purely_real_number
    expected = 3
    assert_equal expected, ComplexNumber.new(3, 0).magnitude
  end

  def test_magnitude_of_a_purely_imaginary_number
    expected = 2
    assert_equal expected, ComplexNumber.new(0, -2).magnitude
  end

  def test_magnitude_of_a_number_with_real_and_imaginary_part
    expected = 10
    assert_in_delta expected, ComplexNumber.new(-6, 8).magnitude, 0.001
  end

  def test_angle_of_a_purely_real_number
    expected = 0
    assert_equal expected, ComplexNumber.new(5.7, 0).angle
  end

  def test_angle_of_a_purely_imaginary_positive_number
    expected = Rational(Math::PI, 2)
    assert_equal expected, ComplexNumber.new(0, 1.34).angle
  end

  def test_angle_of_a_purely_imaginary_negative_number
    expected = -Rational(Math::PI, 2)
    assert_equal expected, ComplexNumber.new(0, -1.34).angle
  end

  def test_angle_of_a_number_with_real_and_imaginary_part
    expected = -Rational(Math::PI, 4)
    assert_in_delta expected, ComplexNumber.new(-3, 3).angle, 0.001
  end

  # test coercion
  def test_coerce_to_complex
    z = ComplexNumber.new(-5, 12)
    expected = [ComplexNumber.new(-3, 2), z]
    assert_equal expected, z.coerce(Complex(-3, 2))
  end

  def test_coerce_a_purely_real_number_to_integer
    z = ComplexNumber.new(4.2, 0)
    expected = [7, 4.2]
    assert_equal expected, z.coerce(7)
  end

  def test_coerce_a_number_with_real_and_imaginary_part_to_integer
    z = ComplexNumber.new(4.2, -5.6)
    expected = [ComplexNumber.new(8, 0), z]
    assert_equal expected, z.coerce(8)
  end

  def test_raise_type_error_when_try_to_coerce_to_vector
    z = ComplexNumber.new(1, 2)
    other = Vector[2]
    exception = assert_raises(TypeError) { z.coerce(other) }
    assert_equal "#{z.class} can't be coerced into #{other.class}", exception.message
  end

  def test_raise_type_error_when_try_to_add_to_vector
    z = ComplexNumber.new(1, 2)
    other = Vector[2]
    exception = assert_raises(TypeError) { other + z }
    # assert_equal "#{z.class} can't be coerced into #{other.class}", exception.message
  end
end
