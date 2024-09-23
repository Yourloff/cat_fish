class SimpleWindow < Gosu::Window
  def initialize(width = 640, height = 480)
    super(width, height)
    self.caption = 'gosu!'
    @font = Gosu::Font.new(20)
    @player = Player.new
    @food = Food.new(width, height)
    @width = width
    @height = height
  end

  def update
    if Gosu.button_down?(Gosu::KB_A)
      @player.move_left
    end
    if Gosu.button_down?(Gosu::KB_D)
      @player.move_right(@width)
    end
    if Gosu.button_down?(Gosu::KB_W)
      @player.move_up
    end
    if Gosu.button_down?(Gosu::KB_S)
      @player.move_down(@height)
    end

    if collision?(@player, @food)
      @player.score += 1
      puts 'Кошка съела рыбку!'
      puts @player.score
      @food = Food.new(@width, @height)
    end
  end

  def draw
    @player.draw
    @food.draw
    @font.draw_text("Счёт: #{@player.score}", 10, 10, 0, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def collision?(player, food)
    player_left = player.x
    player_right = player.x + player.width
    player_top = player.y
    player_bottom = player.y + player.height

    food_left = food.x
    food_right = food.x + food.width
    food_top = food.y
    food_bottom = food.y + food.height

    return false if player_right < food_left || player_left > food_right
    return false if player_bottom < food_top || player_top > food_bottom

    true
  end
end
