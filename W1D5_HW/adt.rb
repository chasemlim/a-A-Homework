class Stack
  def initialize
    @stack = []
  end

  def push(el)
    @stack.unshift(el)
  end

  def pop
    @stack.shift
  end

  def peek
    @stack[0]
  end
end


class Queue
  def initialize
    @queue = []
  end

  def enqueue(el)
    @queue.push(el)
  end

  def dequeue
    @queue.shift
  end

  def peek
    @queue[0]
  end
end


class Map

  def initialize
    @map = []
  end

  def set(key, val)
    exist = false
    @map.each do |pair|
      if key == pair[0]
        pair[1] = val
        exist = true
        break
      end
    end
    if exist == false
      @map << [key, val]
    end
    @map
  end

  def get(key)
    @map.each do |pair|
      return pair[1] if key == pair[0]
    end
  end

  def delete(key)
    deleted = nil
    @map.each.with_index do |pair, idx|
      if key == pair[0]
        deleted = @map.delete_at(idx)
      end
    end
    deleted
  end

  def show
    @map
  end

end
