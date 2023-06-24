require 'rails_helper'

RSpec.describe Like, type: :model do
  like = Like.new(user_id: 1, post_id: 1)

  it 'should has an author id' do
    expect(like.user_id).to_not eql 5
    expect(like.user_id).to eql 1
  end

  it 'should has a post id' do
    expect(like.post_id).to_not eql(-5)
    expect(like.post_id).to eql 1
  end

  it 'checks update_likes_counter method' do
    post = Post.new(author_id: 1, title: 'first post', text: 'this is the first post',
                    comments_counter: 3, likes_counter: 2)
    post.save

    expect(post.likes_counter).to eq(2)
  end
end
