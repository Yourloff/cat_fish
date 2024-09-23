class Player
  SPEED = 5

  attr_reader :x, :y, :width, :height
  attr_accessor :score

  def initialize
    @image = Gosu::Image.new('images/player.png')
    @x = 100
    @y = 100
    @width = @image.width
    @height = @image.height
    @score = 0
    @facing_right = false
  end

  def move_left
    @x -= SPEED if @x - SPEED >= 0
    @facing_right = true
  end

  def move_right(window_width)
    @x += SPEED if @x + SPEED <= window_width - @image.width
    @facing_right = false
  end

  def move_up
    @y -= SPEED if @y - SPEED >= 0
  end

  def move_down(window_height)
    @y += SPEED if @y + SPEED <= window_height - @image.height
  end

  def draw
    if @facing_right
      @image.draw(@x, @y, 1)
    else
      @image.draw(@x + @width, @y, 1, -1, 1)
    end
  end
end
