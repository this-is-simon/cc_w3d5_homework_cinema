require('pg')
require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :funds, :name

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"

    values = [@name, @funds]

    customer = SqlRunner.run(sql, values).first
    @id = customer['id'].to_i
  end

  def update
    sql = "UPDATE customers SET name = $1,
    funds = $2
    WHERE id = $3"

    values = [@name, @funds, @id]

    SqlRunner.run(sql, values)
  end

  def self.all
    sql = "SELECT * FROM customers"
    customer_hash = SqlRunner.run(sql)
    customer_objects = customer_hash.map {|customer| Customer.new(customer)}
    return customer_objects
  end

  def delete
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def find_films
    sql = "SELECT films.*
      FROM films
      INNER JOIN tickets
      ON tickets.film_id = films.id
      WHERE customer_id = $1"
    values = [@id]
    films_array = SqlRunner.run(sql, values)
    film_objects = films_array.map {|film| Film.new(film)}
    return film_objects
  end

  # def show_movies
  #   sql = "SELECT movies.*
  #     FROM movies
  #     INNER JOIN castings
  #     ON castings.movie_id = movies.id
  #     WHERE star_id = $1"
  #   values = [@id]
  #   movies = SqlRunner.run( sql, values )
  #   result = movies.map{ |movie| Movie.new(movie) }
  #   return result
  # end

end
