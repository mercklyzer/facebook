users = [
  {
    username: "lyzer",
    password:"password",
    password_confirmation: "password",
    first_name: "Lyzer",
    last_name: "Bautista",
    email: "lyzer.bautista@gmail.com"
  },
  {
    username: "johndoe",
    password:"password",
    password_confirmation: "password",
    first_name: "John",
    last_name: "Doe",
    email: "john.doe@gmail.com"
  },
  {
    username: "daveinoc",
    password:"password",
    password_confirmation: "password",
    first_name: "Dave",
    last_name: "Inoc",
    email: "dave.inoc@gmail.com"
  },
  {
    username: "azzasajaud",
    password:"password",
    password_confirmation: "password",
    first_name: "Azza",
    last_name: "Sajaud",
    email: "azza.sajaud@gmail.com"
  },
  {
    username: "laser.blitz",
    password:"password",
    password_confirmation: "password",
    first_name: "Laser",
    last_name: "Blitz",
    email: "laser.blitz@gmail.com"
  },
  {
    username: "krieg.kaiser",
    password:"password",
    password_confirmation: "password",
    first_name: "Krieg",
    last_name: "Kaiser",
    email: "krieg.kaiser@gmail.com"
  },
]

users.each do |user|
  user_exists = User.find_by(username: user[:username])
  next if user_exists
  User.create(user)
end
