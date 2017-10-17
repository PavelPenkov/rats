require 'test_helper'

class EitherTest < Minitest::Test
  def setup
    @failure = Rats.failure("Error")
    @success = Rats.success(1)
  end

  def test_equals_failure
    assert(@failure == Rats.failure("Error"))
  end

  def test_equals_success
    assert(@success == Rats.success(1))
  end

  def test_map_failure
    res = @failure.map {|x| x + 1}

    assert_equal(@failure, res)
  end

  def test_map_success
    res = @success.map {|x| x + 1}

    assert_equal(Rats.success(2), res)
  end

  def test_flat_map_failure
    res = @failure.flat_map {|x| Rats.success(x+1)}

    assert_equal(@failure, res)
  end

  def test_flat_map_success
    res = @success.flat_map {|x| Rats.success(x+1) }

    assert_equal(Rats.success(2), res)
  end

  def test_fold_failure
    res = @failure.fold(proc {|x| x}, proc {|x| x + 1})

    assert_equal("Error", res)
  end

  def test_fold_success
    res = @success.fold(proc{|x| x}, proc {|x| x + 1})

    assert_equal(2, res)
  end

  def test_flat_map_invalid_type
    assert_raises TypeError do
      @success.flat_map {|x| x }
    end
  end

  def test_success_success
    assert @success.success?
  end

  def test_failure_success
    refute @success.failure?
  end

  def test_success_failure
    refute @failure.success?
  end

  def test_failure_failure
    assert @failure.failure?
  end
end
