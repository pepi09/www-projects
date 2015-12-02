class User
  attr_accessor :id, :username, :email, :first_name, :last_name, :location

  def initialize(username, email, first_name, last_name, location, id = nil)
    @username = username
    @email = email
    @first_name = first_name
    @last_name = last_name
    @location = location
    @id = id
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
