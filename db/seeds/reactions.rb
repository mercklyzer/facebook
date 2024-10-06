reaction_types = ['like', 'heart', 'care', 'haha', 'wow', 'sad', 'angry'].freeze

posts = Post.all
users = User.all

posts.each do |post|
  user_1, user_2, user_3 = users.sample(3)

  Reaction.create(user: user_1, owner: post, reaction: reaction_types.sample)
  Reaction.create(user: user_2, owner: post, reaction: reaction_types.sample)
  Reaction.create(user: user_3, owner: post, reaction: reaction_types.sample)
end
