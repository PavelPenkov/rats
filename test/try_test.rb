require 'test_helper'

class TryTest < Minitest::Test
  def setup
    @ok = Rats.ok(1)
    @error = Rats.error(StandardError.new("Error"))
  end

  def test_constructor_ok
    tx = Rats.try { 1 }
    assert_instance_of(Rats::Ok, tx)
  end

  def test_constructor_error
    tx = Rats.try { 1 / 0 }
    assert_instance_of(Rats::Error, tx)
  end

  def test_map_ok
    res = @ok.map {|x| x + 1}

    assert_equal(Rats.ok(2), res)
  end

  def test_flat_map_ok
    res = @ok.flat_map {|x| Rats.ok(x + 1)}

    assert_equal(Rats.ok(2), res)
  end

  def test_failed_map_ok
    res = @ok.map {|x| x / 0}

    assert_instance_of(Rats::Error, res)
  end

  def test_to_maybe_ok
    assert_equal(Rats.some(1), @ok.to_maybe)
  end

  def test_to_maybe_error
    assert_equal(Rats.none, @error.to_maybe)
  end

  def test_ok_ok
    assert @ok.ok?
  end

  def test_error_ok
    refute @ok.error?
  end

  def test_ok_error
    refute @error.ok?
  end

  def test_error_error
    assert @error.error?
  end

  def test_value_ok
    assert_equal(1, @ok.value)
  end

  def test_recover_ok
    rec = @ok.recover {|err| err.message}

    assert_equal(@ok, rec)
  end

  def test_recover_error
    rec = @error.recover {|err| err.message}

    assert_equal("Error", rec)
  end

  def test_flat_map_rejects_invalid_type
    assert_raises TypeError do
      @ok.flat_map {|x| x + 1}
    end
  end

  def test_failed_flat_map_ok
    res = @ok.flat_map {|x| x / 0}

    assert_instance_of(Rats::Error, res)
  end

  def test_value_error
    assert_raises StandardError do
      @error.value
    end
  end

  def test_map_error
    res = @error.map {|x| x + 1}

    assert_equal(@error, res)
  end

  def test_flat_map_error
    res = @error.flat_map {|x| Rats.ok(x+1)}

    assert_equal(@error, res)
  end

  def test_constructor_some
    assert_raises ArgumentError do
      Rats.some(nil)
    end
  end
end
