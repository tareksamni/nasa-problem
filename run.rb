require_relative './lib/coordinate'
require_relative './lib/plateau'
require_relative './lib/robot'

if $PROGRAM_NAME == __FILE__
  plateau = nil
  robots = []
  File.open("input.txt", "r") do |f|
    f.each_line do |line|
      if plateau.nil?
        x, y = line.split(" ")
        plateau = Plateau.new(x.to_i,y.to_i)
      elsif line.include?(" ")
        x, y, h = line.split(" ")
        c = Coordinate.new(x.to_i, y.to_i)
        r = Robot.new(c, h)
        plateau.land(r)
        robots << r
      else
        plateau.recieve(line.chars.reject{ |e| e == "\n" })
      end
    end
  end
  robots.each do |robot|
    puts robot
  end
end