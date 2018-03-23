require('pg')
require_relative('../db/sql_runner')

class Film

  attr_reader :id, :title
  attr_accessor :price

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end

  def save
    sql = "INSERT INTO films
    (
      title,
      price
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"

    values = [@title, @price]

    title = SqlRunner.run(sql, values).first
    @id = title['id'].to_i
  end

  def update
    sql = "UPDATE films SET title = $1,
    price = $2
    WHERE id = $3"

    values = [@title, @price, @id]

    SqlRunner.run(sql, values)
  end

  def self.all
    sql = "SELECT * FROM films"
    film_hash = SqlRunner.run(sql)
    film_objects = film_hash.map {|film| Customer.new(film)}
    return film_objects
  end

  def delete
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def find_customers
    sql = "SELECT customers.*
      FROM customers
      INNER JOIN tickets
      ON tickets.customer_id = customers.id
      WHERE film_id = $1"
    values = [@id]
    customers_array = SqlRunner.run(sql, values)
    customer_objects = customers_array.map {|customer| Customer.new(customer)}
    return customer_objects
  end

end
