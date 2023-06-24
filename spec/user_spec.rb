require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.create(name: 'Chere', posts_counter: 3) }
  before { subject.save }

  describe 'user validations' do
    it 'user name should be present' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'post_counter should be present' do
      subject.posts_counter = nil
      expect(subject).to_not be_valid
    end

    it 'posts_counter should be greater than or equal to zero' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end

    it 'bio should be empty' do
      expect(subject.bio).to eq nil
    end

    it 'photo should be empty' do
      expect(subject.photo).to eq nil
    end
  end

  describe 'recent_posts' do
    it 'should returns up to three most recent posts' do
      subject.posts.create!(title: 'Post-1', text: 'Hello', created_at: 7.day.ago,
                            comments_counter: 3, likes_counter: 4)
      post2 = subject.posts.create!(title: 'Post-2', text: 'Hi there', created_at: 3.days.ago,
                                    comments_counter: 1, likes_counter: 5)
      post3 = subject.posts.create!(title: 'Post-3', text: 'How are you', created_at: 1.days.ago,
                                    comments_counter: 0, likes_counter: 1)
      post4 = subject.posts.create!(title: 'Post-4', text: 'Selam selam', created_at: 4.days.ago,
                                    comments_counter: 4, likes_counter: 3)

      expect(subject.recent_posts.to_a).to eq [post3, post2, post4]
    end
  end
end
