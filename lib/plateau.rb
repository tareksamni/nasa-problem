require_relative './errors'

class Plateau
  attr_reader :max_x, :max_y, :robot
  def initialize(max_x, max_y)
    @max_x, @max_y = max_x, max_y
  end

  def land(robot)
    raise OutOfPlateauLand, "Robot landed out of plateau space" unless valid?(robot)
    @robot = robot
  end

  def recieve(instructions)
    raise RobotNotLanded, "Robot not landed yet, Land a robot first." if robot.nil?
    robot.start(instructions)
  end

  def valid?(robot)
    # Need to ask if a robot can go to:
    # negative coordinates 
    # EX: (-5,5) or (-3,-1)
    robot.coordinate.x <= max_x && robot.coordinate.y <= max_y
  end
end