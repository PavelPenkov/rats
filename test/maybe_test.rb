require 'test_helper'

class MaybeTest < Minitest::Test
  def setup
    @some = Rats.some(1)
    @none = Rats.none
  end
  def test_value_some
    assert_equal(1, @some.value)
  end

  def test_map_some
    minc = @some.map{|x| x + 1}

    assert_equal(minc, Rats.some(2))
  end

  def test_flat_map_some
    minc = @some.flat_map{|x| Rats.some(x + 1)}

    assert_equal(minc, Rats.some(2))
  end

  def test_has_value_some
    assert @some.has_value?
  end

  def test_has_value_none
    refute @none.has_value?
  end

  def test_value_none
    assert_raises NoMethodError do
      @none.value
    end
  end

  def test_map_none
    minc = @none.map {|x| x + 1}

    assert_equal(minc, Rats.none)
  end

  def test_flat_map_none
    minc = @none.flat_map {|x| Rats.some(x + 1) }

    assert_equal(Rats.none, minc)
  end

  def test_eq_some
    my = Rats.some(1)

    assert(@some == my)
  end

  def test_eq_none
    my = Rats.none

    assert(@none == my)
  end

  def test_length_some
    assert_equal(1, @some.count)
  end

  def test_length_none
    assert_equal(0, @none.count)
  end

  def test_flat_map_rejects_invalid_type_success
    assert_raises TypeError do
      @some.flat_map {|x| x + 1}
    end
  end
end
