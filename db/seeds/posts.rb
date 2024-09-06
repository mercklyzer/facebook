(1..10).each do |i|
  Post.create(
    content: "This is post number #{i}."
  )
end
