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
end
