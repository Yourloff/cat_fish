class SimpleWindow < Gosu::Window
  def initialize(width = 640, height = 480)
    super(width, height, fullscreen: false, borderless: true)
    self.caption = 'A cat eats a fish'
    @background_image = Gosu::Image.new("images/floor.jpg", :tileable => true)
    @font = Gosu::Font.new(20)
    @player = Player.new
    @food = Food.new(width, height)
    @width = width
    @height = height

    @close_button_size = 20
    @close_button_x = width - @close_button_size - 10
    @close_button_y = 10
  end

  def update
    if button_down?(Gosu::MsLeft) && over_close_button?(mouse_x, mouse_y)
      close
    end

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
    @background_image.draw(0, 0, 0)
    @player.draw
    @food.draw
    @font.draw_text("Счёт: #{@player.score}", 10, 10, 0, 1.0, 1.0, Gosu::Color::YELLOW)

    draw_close_button
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

  def over_close_button?(mouse_x, mouse_y)
    mouse_x >= @close_button_x && mouse_x <= (@close_button_x + @close_button_size) &&
      mouse_y >= @close_button_y && mouse_y <= (@close_button_y + @close_button_size)
  end

  # Отрисовка кнопки "Закрыть"
  def draw_close_button
    Gosu.draw_rect(@close_button_x, @close_button_y, @close_button_size, @close_button_size, Gosu::Color::RED, 1)

    # Вычисление центра кнопки для размещения "X"
    x_offset = @close_button_x + (@close_button_size / 4)
    y_offset = @close_button_y - 1

    # Отрисовка символа "X" по центру кнопки
    @font.draw_text("X", x_offset, y_offset, 3, 1.0, 1.0, Gosu::Color::WHITE)
  end
end
