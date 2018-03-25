require('pg')
require_relative('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id, :film_time

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
    @film_time = options['film_time']
  end

    def save
      sql = "INSERT INTO tickets
      (
        customer_id,
        film_id,
        film_time
      )
      VALUES
      (
        $1, $2, $3
      )
      RETURNING id"

      values = [@customer_id, @film_id, @film_time]

      ticket = SqlRunner.run(sql, values).first
      @id = ticket['id'].to_i
    end

    def update
      sql = "UPDATE tickets SET customer_id = $1,
      film_id = $2, film_time = $3
      WHERE id = $4"

      values = [@customer_id, @film_id, @film_time, @id]

      SqlRunner.run(sql, values)
    end

    def self.all
      sql = "SELECT * FROM tickets"
      ticket_hash = SqlRunner.run(sql)
      ticket_objects = ticket_hash.map {|ticket| Ticket.new(ticket)}
      return ticket_objects
    end

    def delete
      sql = "DELETE FROM tickets WHERE id = $1"
      values = [@id]
      SqlRunner.run(sql, values)
    end

    def self.delete_all
      sql = "DELETE FROM tickets"
      SqlRunner.run(sql)
    end

end
