require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Playwright

  attr_accessor :id, :name, :birth_year

  def self.all
    p_data = PlayDBConnection.instance.execute("SELECT * FROM playwrights")
    p_data.map { |d| Playwright.new(d) }
  end

  def self.find_by_name(name)
    pw_arr = Playwright.all

    pw_arr.each do |pw|
      return pw if pw.name == name
    end
  end

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year)
      INSERT INTO
        playwrights (name, birth_year)
      VALUES
        (?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id

    PlayDBConnection.instance.execute(<<-SQL, self.name, self.birth_year)
      UPDATE
        playwrights
      SET
        name = ?, birth_year = ?
      WHERE
        id = ?
    SQL
  end

  def get_plays
    play_arr = Play.all
    plays = []

    play_arr.each do |play|
      plays << play if play.playwright_id == id
    end
    plays
  end

end

class Play
  attr_accessor :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def self.find_by_title(title)
    play_arr = Play.all

    play_arr.each do |play|
      return play if play.title == title
    end
  end

  def self.find_by_playwright(name)
    play_arr = Play.all
    pw = Playwright.all.select { |playwright| playwright.name == name }

    play_arr.each do |play|
      return play if pw[0].id == play.playwright_id
    end
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id, self.id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end


end
