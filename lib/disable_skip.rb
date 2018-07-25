require 'minitest/autorun'

module Minitest
  class Test
    def skip(_msg = '', _bt = caller)
    end
  end
end
