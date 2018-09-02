require_relative 'complex_numbers_test'
# OR:
# require 'minitest/autorun'
# require_relative 'complex_numbers'
# run multiple tests:
# $ for file in complex_numbers/*.rb; do ruby -I lib -r disable_skip -r minitest/pride $file; done 

require 'matrix'

class ComplexNumberExtendedTest < Minitest::Test
  # test coercion
  def test_coerce_to_complex
    z = ComplexNumber.new(-5, 12)
    expected = [ComplexNumber.new(-3, 2), z]
    assert_equal expected, z.coerce(Complex(-3, 2))
  end

  def test_coerce_purely_real_complex_number_to_integer
    z = ComplexNumber.new(4.2, 0)
    expected = [7, 4.2]
    assert_equal expected, z.coerce(7)
  end

  def test_coerce_complex_number_with_real_and_imaginary_part_to_integer
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
