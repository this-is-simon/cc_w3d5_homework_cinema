require('pg')
require_relative('../db/sql_runner')
require_relative('./ticket')

class Screening

  attr_reader :id
  attr_accessor :film_time, :available_seats

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @film_time = options['film_time']
    @available_seats = options['available_seats']
  end

  def save
    sql = "INSERT INTO screenings
    (
      film_time, available_seats
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"

    values = [@film_time, @available_seats]

    ticket = SqlRunner.run(sql, values).first
    @id = ticket['id'].to_i
  end

  def update
    sql = "UPDATE screenings SET film_time = $1, available_seats = $2
    WHERE id = $3"

    values = [@film_time, @available_seats, @id]

    SqlRunner.run(sql, values)
  end

  def self.all
    sql = "SELECT * FROM screenings"
    screening_hash = SqlRunner.run(sql)
    screening_objects = screening_hash.map {|screening| Screening.new(screening)}
    return screening_objects
  end

  def self.all_plus_film
    sql = "SELECT films.title, film_time FROM films
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
