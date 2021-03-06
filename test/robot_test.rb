require 'minitest/autorun'
require_relative '../lib/robot'
require_relative '../lib/coordinate'
require_relative 'test_helper'

class RobotTest < Minitest::Test
  attr_reader :x, :y, :robot

  def setup
    @x = 1
    @y = 2
    @robot = Robot.new(Coordinate.new(@x, @y), 'N')
  end

  def test_a_robot
    assert_instance_of Robot, robot
  end

  def test_a_bad_robot
    assert_raises ArgumentError do
      Robot.new(Coordinate.new(@x, @y), 'Z')
    end
  end

  def test_a_robot_initialize
    assert_equal robot.coordinate.x, x
    assert_equal robot.coordinate.y, y
    assert_equal robot.heading, 'N'
  end

  def test_to_s
    s = robot.to_s.split(' ')
    assert_equal s.size, 3
    assert int?(s[0])
    assert int?(s[1])
    assert %w(N W E S).include?(s[2])
  end

  def test_locate
    assert_equal robot.coordinate.x, x
    assert_equal robot.coordinate.y, y
    robot.locate(Coordinate.new(1, 5))
    assert_equal robot.coordinate.x, 1
    assert_equal robot.coordinate.y, 5
  end

  def test_spin_right
    robot.spin_right
    assert_equal robot.heading, 'E'
    robot.spin_right
    assert_equal robot.heading, 'S'
    robot.spin_right
    assert_equal robot.heading, 'W'
    robot.spin_right
    assert_equal robot.heading, 'N'
  end

  def test_spin_left
    robot.spin_left
    assert_equal robot.heading, 'W'
    robot.spin_left
    assert_equal robot.heading, 'S'
    robot.spin_left
    assert_equal robot.heading, 'E'
    robot.spin_left
    assert_equal robot.heading, 'N'
  end

  def test_move_north
    robot.move_forward
    assert_equal robot.coordinate.x, x
    assert_equal robot.coordinate.y, (y + 1)
  end

  def test_move_east
    robot.spin_right
    robot.move_forward
    assert_equal robot.coordinate.x, (x + 1)
    assert_equal robot.coordinate.y, y
  end

  def test_move_south
    robot.spin_right
    robot.spin_right
    robot.move_forward
    assert_equal robot.coordinate.x, x
    assert_equal robot.coordinate.y, (y - 1)
  end

  def test_move_west
    robot.spin_left
    robot.move_forward
    assert_equal robot.coordinate.x, (x - 1)
    assert_equal robot.coordinate.y, y
  end

  def test_good_start
    robot.start(%w(L M L M L M L M M))
    assert_equal robot.coordinate.x, 1
    assert_equal robot.coordinate.y, 3
    assert_equal robot.heading, 'N'
  end

  def test_bad_start
    assert_raises ArgumentError do
      robot.start(%w(L M F M L M L M M))
    end
  end
end
