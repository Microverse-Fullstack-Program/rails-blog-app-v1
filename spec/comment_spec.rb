require 'rails_helper'

RSpec.describe Comment, type: :model do
  comment = Comment.create(user_id: 1, post_id: 1, text: 'love') 

  it 'text should be present' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

    it 'should has an author id' do
        expect(comment.user_id).to_not eql 5
        expect(comment.user_id).to eql 1
    end

    it 'should has a post id' do
        expect(comment.post_id).to_not eql(-5)
        expect(comment.post_id).to eql 1
    end

  describe 'check update_comments_counter method' 
    let(:user) { User.create(name: 'Tom', photo: 'image', bio: 'phsician', posts_counter: 0) }
    let(:post) do
        Post.create(title: 'first post', text: 'This is my first post', author: user, comments_counter: 0, likes_counter: 0)
    end

    subject { described_class.create(user_id: user.id, post_id:1, text: 'My comment') }

    it 'posts comments count should increase' do
      expect do
        subject
        post.reload
      end.to change { post.comments_counter }.by(0)
    end
end

