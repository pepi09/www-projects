class User
  attr_accessor :username, :email, :first_name, :last_name, :location

  def initialize(username, email, first_name, last_name, location)
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
