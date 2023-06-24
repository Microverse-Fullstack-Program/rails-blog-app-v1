require 'rails_helper'

describe Post, type: :model do
  let(:user) { User.create(name: 'Chere') }

  subject { Post.new(title: 'Ruby on Rails', text: 'Rails is magic', author: user) }
  before { subject.save }

  describe 'posts validations' do
    it 'title should be present' do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it 'maximum length of title should be 250 characters' do
      subject.title = 'abc' * 100
      expect(subject).to_not be_valid
    end

    it 'text should be present' do
      subject.text = nil
      expect(subject).to_not be_valid
    end

    it 'maximum length of title should be 250 characters' do
      subject.title = 'abcde' * 300
      expect(subject).to_not be_valid
    end

    it 'comments_counter should be an integer' do
      subject.comments_counter = 'not a number'
      expect(subject).to_not be_valid
    end

    it 'comments_counter should be greater than or equal to zero' do
      subject.comments_counter = -10
      expect(subject).to_not be_valid
    end

    it 'likes_counter should be an integer' do
      subject.likes_counter = 'not a number'
      expect(subject).to_not be_valid
    end

    it 'likes_counter hould be greater than or equal to zero' do
      subject.likes_counter = -10
      expect(subject).to_not be_valid
    end
  end

  describe '#update_user_posts_counter' do
    it 'increments the user posts_counter after save' do
      user.posts_counter = 0
      subject.update_posts_counter
      expect(user.posts_counter).to eq(1)
    end

    it 'decrements the user posts_counter after destroy' do
      user.posts_counter = 1
      subject.destroy
      expect(user.posts_counter).to eq(0)
    end
  end

  describe 'recent_posts' do
    before(:example) do
      @user = User.create(name: 'Tom Kiru', photo: '3*4 person image', bio: 'I am a student', posts_counter: 1)
      @post = Post.create(title: 'My first post', text: 'Post message', author: @user, comments_counter: 3,
                          likes_counter: 2)
    end

    let!(:comment1) do
      Comment.create(text: 'Comment-1', author: @user, post: @post)
    end
    let!(:comment2) do
      Comment.create(text: 'Comment-1', author: @user, post: @post)
    end
    let!(:comment3) do
      Comment.create(text: 'Comment-3', author: @user, post: @post)
    end
    let!(:comment4) do
      Comment.create(text: 'Comment-4', author: @user, post: @post)
    end
    let!(:comment5) do
      Comment.create(text: 'Comment-5', author: @user, post: @post)
    end

    it 'should return recent 3 comments' do
      expect(@post.recent_comments).to include(comment1, comment2, comment3, comment4, comment5)
    end
  end
end
