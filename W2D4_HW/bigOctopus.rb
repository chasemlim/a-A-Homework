def sluggishOctopus(array)
  biggest = array.first
  bigboi = true
  while bigboi == true
    bigboi = false
    array.each do |fish|
      if fish.length > biggest.length
        bigboi = true
        biggest = fish
      end
    end
  end
  biggest
end

def dominantOctopus(array)
  return array if array.length.zero?

  return array if array.length == 1

  mid = array.length / 2

  left = dominantOctopus(array[0...mid])
  right = dominantOctopus(array[mid..-1])

  if array[mid - 1].length < array[mid].length
    return left[0] + left[1..-1]
  elsif array[mid + 1].length > array[mid].length
    return right[0] + right[1..-1]
  end
  left + right
end


def cleverOctopus(array)
  hold = array[0]

  array.each do |fish|
    hold = fish if hold.length < fish.length
  end
  hold
end

TILES_ARRAY = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

def slowDance(move, tiles_array)
  tiles_array.each_with_index do |tile, idx|
    return idx if move == tile
  end
end

TILES_HASH = {
  "up" => 0,
  "right-up" => 1,
  "right" => 2,
  "right-down" => 3,
  "down" => 4,
  "left-down" => 5,
  "left" => 6,
  "left-up" => 7
}

def fastDance(move, tiles_hash)
  tiles_hash[move]
end
