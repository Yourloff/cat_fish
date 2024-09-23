class Food
  attr_reader :x, :y, :width, :height

  def initialize(width, height)
    fish = %w[images/fish1.png images/fish2.png images/fish3.png]
    @image = Gosu::Image.new(fish.sample)
    @x = rand(0..(width - @image.width))
    @y = rand(0..(height - @image.height))
    @angle = 0.0
    @width = @image.width
    @height = @image.height
  end

  def draw
    @image.draw_rot(@x, @y, 1, @angle)
  end
end
