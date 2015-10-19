require 'sqlite3'
require './app/models/user'

DB = SQLite3::Database.new './db/database.sqlite3'

module UserRepository
  extend self

  def create(user)
    DB.execute <<-SQL
      INSERT INTO users (
        `username`, `email`, `first_name`, `last_name`, `location`
      ) VALUES (
        '#{user.username}', '#{user.email}', '#{user.first_name}', '#{user.last_name}', '#{user.location}'
      );
    SQL
  end

  def find(id)
    columns, row = DB.execute2 "SELECT * FROM users WHERE id = #{id};"
    return unless row

    user_attributes = columns.zip(row).to_h
    User.new(
      user_attributes['email'],
      user_attributes['username'],
      user_attributes['first_name'],
      user_attributes['last_name'],
      user_attributes['location'],
    )
  end

  def update(user)
    DB.execute <<-SQL
      UPDATE users
      SET
        username = '#{user.username}',
        email = '#{user.email}',
        first_name = '#{user.first_name}',
        last_name = '#{user.last_name}',
        location = '#{user.location}'
      WHERE id = #{user.id};
    SQL
  end

  def delete(id)
    DB.execute "DELETE FROM users WHERE id = #{id};"
  end

  def followers(id)
    columns, *rows = DB.execute2 <<-SQL
      SELECT email, username, first_name, last_name, location FROM users
      JOIN users_followers
      ON users.id = users_followers.follower_id
      WHERE users_followers.followed_id = #{1};
    SQL

    return unless rows

    rows.map do |row|
      user_attributes = columns.zip(row).to_h

      User.new(
        user_attributes['email'],
        user_attributes['username'],
        user_attributes['first_name'],
        user_attributes['last_name'],
        user_attributes['location'],
      )
    end
  end

  def following(id)
  end
end
