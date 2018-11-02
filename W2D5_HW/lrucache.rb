class LRUCache
  def initialize(size)
    @cache = Array.new(0)
    @size = size
  end

  def count
    @cache.length
  end

  def add(el)
    if @cache.include?(el)
      @cache.delete(el)
    elsif self.count == @size
      @cache.shift
    end
    @cache.push(el)
  end

  def show
    @cache
  end

  private
  # helper methods go here!

end
