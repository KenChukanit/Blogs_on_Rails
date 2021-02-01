
Post.delete_all
Comment.delete_all
User.delete_all

NUM_OF_POSTS = 50
NUM_USER=15
BODY_50_CHARS = "I am the body. I have to be 50 characters. So, I have to be here to help the seed to be success."


PASSWORD='supersecret'
super_user= User.create(
    name: 'Ken',
    email: 'chonlasek.c@gmail.com',
    password: 'concon',
    admin: true
)

NUM_USER.times do
    name= Faker::Name.first_name 
    User.create(
        name: name,
        email: "#{name}@example.com",
        password: PASSWORD
    )
    end

users=User.all

NUM_OF_POSTS.times do
    created_at = Faker::Date.backward(days: 30)
    p = Post.create(
        title: Faker::Hacker.say_something_smart,
        body: BODY_50_CHARS,
        user: users.sample
    )
    
    if p.valid?
        p.comments = rand(0..15).times.map do
            Comment.new(
                body: Faker::GreekPhilosophers.quote,
                user: users.sample
            )
        end
        
    
    end

end

posts = Post.all
comments = Comment.all

puts Cowsay.say("Created #{posts.count} posts", :koala)
puts Cowsay.say("Created #{comments.count} comments.",:frogs)
puts Cowsay.say("Created #{users.count} users.",:sheep)