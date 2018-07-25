class ComplexNumber
  attr_reader :real, :imaginary
    
  def initialize(real, imaginary)
    @real = real
    @imaginary = imaginary
  end

  def ==(z)
    @real == z.real && @imaginary == z.imaginary
  end

  def +(z)
    ComplexNumber.new(@real + z.real, @imaginary + z.imaginary)
  end

  def -(z)
    ComplexNumber.new(@real - z.real, @imaginary - z.imaginary)
  end

  def *(z)
    real = @real * z.real - @imaginary * z.imaginary
    imaginary = @real * z.imaginary + @imaginary * z.real
    ComplexNumber.new(real, imaginary)
  end

  def /(z)
    numerator = self * z.conjugate
    denominator = z.abs ** 2
    ComplexNumber.new(numerator.real / denominator, numerator.imaginary / denominator)
  end

  def conjugate
    ComplexNumber.new(@real, -@imaginary)
  end

  def abs
    Math.sqrt(@real ** 2 + @imaginary ** 2)
  end

  def exp
    case @imaginary
    when 0, 2 * Math::PI # cause Math.sin(Math::PI != 0)
      unit = ComplexNumber.new(1, 0)
    when 0.5 * Math::PI
      unit = ComplexNumber.new(0, 1)
    when Math::PI
      unit = ComplexNumber.new(-1, 0)
    when 1.5 * Math::PI
      unit = ComplexNumber.new(0, -1)
    else
      unit = ComplexNumber.new(Math.cos(@imaginary), Math.sin(@imaginary))
    end
    unit * Math.exp(@real)
  end

  def coerce(other)
    case other
    when Integer, Float
      if (@imaginary == 0)
        return other, @real
      else
        return ComplexNumber.new(other, 0), self
      end
    end
    raise TypeError, "ComplexNumber can't be coerced into #{other.class}"
  end
end

module BookKeeping
  VERSION = 1 # Where the version number matches the one in the test.
end
