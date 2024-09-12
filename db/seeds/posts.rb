(1..10).each do |i|
  user_ids = User.select(:id).distinct.limit(5).pluck(:id)
  random_user_id = user_ids.sample
  user = User.find(random_user_id)

  Post.create(
    content: "This is post number #{i}.",
    user: user
  )
end
