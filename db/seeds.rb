
Post.delete_all

Comment.delete_all


NUM_OF_POSTS = 50

BODY_50_CHARS = "I am the body. I have to be 50 characters. So, I have to be here to help the seed to be success."

NUM_OF_POSTS.times do
    created_at = Faker::Date.backward(days: 30)
    p = Post.create(
        title: Faker::Hacker.say_something_smart,
        body: BODY_50_CHARS
    )
    
    if p.valid?
        p.comments = rand(0..15).times.map do
            Comment.new(
                body: Faker::GreekPhilosophers.quote
            )
        end
        
       
    end

end

posts = Post.all
comments = Comment.all

puts Cowsay.say("Created #{posts.count} posts", :koala)
puts Cowsay.say("Created #{comments.count} comments.",:frogs)