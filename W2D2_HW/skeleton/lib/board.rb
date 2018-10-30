class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) { Array.new(0) }
    place_stones
  end
  require 'byebug'
  def place_stones # number 6 and 13 are the stores
    @cups.each_with_index do |_cup, idx|
      if idx != 6 && idx != 13
        @cups[idx] += %i[stone stone stone stone]
      end
    end
  end

  def valid_move?(start_pos)
    if start_pos > 13 || start_pos < 0
      raise "Invalid starting cup"
    elsif @cups[start_pos].empty?
      raise "Starting cup is empty"
    else
      true
    end
  end

  def make_move(start_pos, current_player_name)
    current_hand = @cups[start_pos]
    @cups[start_pos] = []
    i = start_pos + 1
    # debugger
    until current_hand.empty?
      i = 0 if i == 14
      if i == 6 && current_player_name != @name1
        i += 1
      elsif i == 13 && current_player_name != @name2
        i += 1
      else
        stone = current_hand.pop
        @cups[i] += [stone]
        i += 1
      end
    end

    render
    next_turn(i - 1)
  end

  def next_turn(ending_cup_idx)
    if @cups[ending_cup_idx].length == 1 && (ending_cup_idx != 6 && ending_cup_idx != 13)
      :switch
    elsif ending_cup_idx == 6 || ending_cup_idx == 13
      :prompt
    else
    ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    empty = true
    @cups[0..5].each do |cup|
      empty = false unless cup.empty?
    end

    return empty if empty == true
    empty = true
    @cups[7..12].each do |cup|
      empty = false unless cup.empty?
    end
    empty
  end

  def winner
    if @cups[6].length > @cups[13].length
      @name1
    elsif @cups[6].length < @cups[13].length
      @name2
    else
      :draw
    end
  end
end
