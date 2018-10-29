class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    while @game_over == false
      take_turn
    end
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    user_input = require_sequence

    @game_over = true unless user_input == @seq

    if @game_over == false
      round_success_message
      @sequence_length += 1
      show_sequence
      require_sequence
    end
  end

  def show_sequence
    add_random_color
    @seq.each { |color| puts color }
  end

  def require_sequence
    p "Enter the sequence!"
    input = []
    @seq.each do |color|
      input << gets.chomp
      # return false unless same_colors(color, input)
    end
    input
  end

  def same_colors(seq_color, input)
    seq_color == input
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message
    puts "Good Job!"
  end

  def game_over_message
    puts "Oops! Game Over!"
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end
