class User
  attr_accessor :id, :username, :email, :first_name, :last_name, :location

  def initialize(id, username, email, first_name, last_name, location)
    @id = id
    @username = username
    @email = email
    @first_name = first_name
    @last_name = last_name
    @location = location
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
