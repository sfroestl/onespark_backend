##
# The Friendship Model class
#
# the association table for user-friendship-user association
#
# Author::    Sebastian Fröstl  (mailto:sebastian@froestl.com)
# Last Edit:: 21.07.2012


class Friendship < ActiveRecord::Base
  attr_accessible :friend_id, :status
  belongs_to :user
  belongs_to :friend, :class_name => "User"
  validates_presence_of :user_id, :friend_id, :status
  validates_uniqueness_of :friend_id, :scope => :user_id, :message => "Already requested this user."
  validates_uniqueness_of :user_id, :scope => :friend_id, :message => "Already requested this user."

  # Return true if the users are (possibly pending) friends.
  def self.exists?(user, friend)
    not find_by_user_id_and_friend_id(user, friend).nil?
  end

  # Record a pending friend request.
  def self.request(user, friend)
    unless user.id == friend.id or Friendship.exists?(user, friend)
      transaction do
        friend.friendships.create(friend_id: user.id, status: 'requested')
      	user.friendships.create(friend_id: friend.id, status: 'pending')
        # create(:user => user, :friend => friend, :status => 'pending')
        # create(:user => friend, :friend => user, :status => 'requested')
      end
	  end
  end

  # Accept a friend request.
  def self.accept(user, friend)
    transaction do
      accepted_at = Time.now
      accept_one_side(user, friend, accepted_at)
      accept_one_side(friend, user, accepted_at)
	 end
  end


  # Delete a friendship or cancel a pending request.
  def self.breakup(user, friend)
    transaction do
      destroy(find_by_user_id_and_friend_id(user, friend))
      destroy(find_by_user_id_and_friend_id(friend, user))
	 end
  end

private

  # Update the db with one side of an accepted friendship request.
  def self.accept_one_side(user, friend, accepted_at)
    request = find_by_user_id_and_friend_id(user, friend)
    request.status = 'accepted'
    request.accepted_at = accepted_at
    request.save!
  end
end
