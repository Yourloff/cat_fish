class Player
  SPEED = 5

  attr_reader :x, :y, :width, :height
  attr_accessor :score

  def initialize
    @image = Gosu::Image.new('images/player.png')
    @x = 100
    @y = 100
    @angle = 0.0
    @width = @image.width
    @height = @image.height
    @score = 0
  end

  def move_left
    @x -= SPEED if @x - SPEED >= 0
  end

  def move_right(window_width)
    @x += SPEED if @x + SPEED <= window_width - @image.width
  end

  def move_up
    @y -= SPEED if @y - SPEED >= 0
  end

  def move_down(window_height)
    @y += SPEED if @y + SPEED <= window_height - @image.height
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end
