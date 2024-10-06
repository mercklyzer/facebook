user_1, user_2, user_3, user_4, user_5, user_6 = User.limit(6)

# pending friend requests
# user_1 -> user_2
# user_1 -> user_3
# user_1 -> user_4
# user_1 -> user_5
# user_1 -> user_6
user_1.send_friend_request(user_2)
user_1.send_friend_request(user_3)
user_1.send_friend_request(user_4)
user_1.send_friend_request(user_5)
user_1.send_friend_request(user_6)

# accepted friend requests
# user_2 <-> user_3
# user_2 <-> user_4
# user_2 <-> user_5
# user_2 <-> user_6
user_2.send_friend_request(user_3)
user_2.send_friend_request(user_4)
user_2.send_friend_request(user_5)
user_2.send_friend_request(user_6)

user_3.accept_friend_request(user_2)
user_4.accept_friend_request(user_2)
user_5.accept_friend_request(user_2)
user_6.accept_friend_request(user_2)

# rejected friend requests
# user_3 </> user_4
# user_3 </> user_6
# user_3 </> user_5
user_3.send_friend_request(user_4)
user_3.send_friend_request(user_5)
user_3.send_friend_request(user_6)

user_4.reject_friend_request(user_3)
user_5.reject_friend_request(user_3)
user_6.reject_friend_request(user_3)
