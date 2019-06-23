class ComplexNumber
  attr_reader :real, :imag

  alias_method :imaginary, :imag

  def initialize(real, imaginary)
    @real = real
    @imag = imaginary
  end

  def magnitude
    return real.abs if imag == 0
    return imag.abs if real == 0
    Math.sqrt(real ** 2 + imag ** 2)
  end

  def angle
    if real == 0
      (imag <=> 0) * Rational(Math::PI, 2)
    else
      Math.atan(imag / real)
    end
  end

  def ==(z)
    real == z.real && imag == z.imag
  end

  def +(z)
    ComplexNumber.new(real + z.real, imag + z.imag)
  end

  def -(z)
    self.class.new(real - z.real, imag - z.imag)
  end

  def *(z)
    real = @real * z.real - @imag * z.imag
    imag = @real * z.imag + @imag * z.real
    self.class.new(real, imag)
  end

  def /(z)
    numerator = self * z.conjugate
    denominator = z.abs ** 2
    self.class.new(numerator.real / denominator, numerator.imag / denominator)
  end

  def conjugate
    self.class.new(real, -imag)
  end

  def abs
    Math.sqrt(real ** 2 + imag ** 2)
  end

  def exp
    unit = case imag
           when 0, 2 * Math::PI # cause Math.sin(Math::PI) != 0
             self.class.new(1, 0)
           when 0.5 * Math::PI
             self.class.new(0, 1)
           when Math::PI
             self.class.new(-1, 0)
           when 1.5 * Math::PI
             self.class.new(0, -1)
           else
             self.class.new(Math.cos(imag), Math.sin(imag))
           end
    unit * Math.exp(real)
  end

  def coerce(other)
    case other
    when Complex
      [self.class.new(other.real, other.imag), self]
    when Integer, Float
      return other, real if imag == 0
      [self.class.new(other, 0), self]
    else
      raise TypeError, "#{self.class} can't be coerced into #{other.class}"
    end
  end
end

module BookKeeping
  VERSION = 1 # Where the version number matches the one in the test.
end
