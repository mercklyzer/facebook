posts = Post.all
users = User.all

ctr = 1

posts.each do |post|
  user_1, user_2, user_3 = users.sample(3)

  Comment.create(user: user_1, post: post, content: "This is comment #{ctr}")
  ctr += 1
  Comment.create(user: user_2, post: post, content: "This is comment #{ctr}")
  ctr += 1
  Comment.create(user: user_3, post: post, content: "This is comment #{ctr}")
  ctr += 1
end
