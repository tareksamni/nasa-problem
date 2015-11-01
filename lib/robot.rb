class Robot
  HEADINGS = ['N', 'E', 'S', 'W']
  INSTRUCTIONS = {
    "R" => :spin_right,
    "L" => :spin_left,
    "M" => :move_forward
  }

  attr_reader :coordinate, :heading
  
  def initialize(coordinate, heading)
    raise ArgumentError, "Invalid heading: #{heading}" unless valid_heading?(heading)
    @heading = heading
    locate(coordinate)
  end

  def start(instructions)
    instructions.each do |ins|
      raise ArgumentError, "Invalid instruction: #{ins}" unless valid_instruction?(ins)
      send(INSTRUCTIONS[ins])
    end
  end

  def to_s
    "#{coordinate.x} #{coordinate.y} #{heading}"
  end

  def locate(coordinate)
    @coordinate = coordinate
  end

  def spin_right
    @heading = HEADINGS[(HEADINGS.index(heading) + 1) % 4]
  end

  def spin_left
    @heading = HEADINGS[(HEADINGS.index(heading) - 1) % 4]
  end

  def move_forward
    send("move_#{heading.to_s.downcase}")
  end

  private

  def valid_heading?(heading)
    HEADINGS.include?(heading)
  end

  def valid_instruction?(instruction)
    INSTRUCTIONS.keys.include?(instruction)
  end

  def move_n
    coordinate.y += 1
  end

  def move_e
    coordinate.x += 1
  end

  def move_s
    coordinate.y += -1
  end

  def move_w
    coordinate.x += -1
  end
end