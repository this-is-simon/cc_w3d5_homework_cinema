require('pg')
require_relative('../db/sql_runner')

class Screening

  attr_reader :id
  attr_accessor :film_time

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @film_time = options['film_time']
  end

  def save
    sql = "INSERT INTO screenings
    (
      film_time
    )
    VALUES
    (
      $1
    )
    RETURNING id"

    values = [@film_time]

    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def update
    sql = "UPDATE screenings SET film_time = $1
    WHERE id = $2"

    values = [@film_time, @id]

    SqlRunner.run(sql, values)
  end

  def self.all
    sql = "SELECT * FROM screenings"
    screening_hash = SqlRunner.run(sql)
    screening_objects = screening_hash.map {|screening| Screening.new(screening)}
    return screening_objects
  end

  def self.all_plus_film
    sql = "SELECT * FROM films
    INNER JOIN tickets
    ON tickets.film_id = films.id
    INNER JOIN screenings
    ON screenings.id = tickets.screening_id"
    film_hash = SqlRunner.run(sql)
    film_objects = film_hash.map {|screening| Screening.new(screening)}
    return film_objects
  end

  def delete
    sql = "DELETE FROM screenings WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

end
