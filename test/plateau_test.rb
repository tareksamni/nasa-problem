require 'minitest/autorun'
require_relative '../lib/plateau'
require_relative '../lib/robot'

class PlateauTest < Minitest::Test
  attr_reader :x, :y, :plateau
  def setup
    @x = 5
    @y = 5
    @plateau = Plateau.new(@x, @y)
  end

  def test_a_plateau
    assert_instance_of Plateau, plateau
  end

  def test_a_plateau_initialize
    assert_equal plateau.max_x, x
    assert_equal plateau.max_y, y
  end

  def test_good_land
    robot = Robot.new(Coordinate.new(3, 5), 'E')
    plateau.land(robot)
    assert_equal plateau.robot.coordinate.x, 3
    assert_equal plateau.robot.coordinate.y, 5
    assert_equal plateau.robot.heading, 'E'
  end

  def test_bad_land
    robot = Robot.new(Coordinate.new(6, 5), 'E')
    assert_raises OutOfPlateauLand do
      plateau.land(robot)
    end
  end

  def test_bad_recieve
    assert_raises RobotNotLanded do
      plateau.recieve('LMLMLMLMM')
    end
  end

  def test_good_recieve
    robot = Robot.new(Coordinate.new(1, 2), 'N')
    plateau.land(robot)
    plateau.recieve('LMLMLMLMM'.chars)
    assert_equal plateau.robot.coordinate.x, 1
    assert_equal plateau.robot.coordinate.y, 3
    assert_equal plateau.robot.heading, 'N'
  end
end
