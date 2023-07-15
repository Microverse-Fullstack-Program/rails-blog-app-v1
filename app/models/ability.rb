class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here. For example:
    can :read, :all

    return unless user.present?

    can :manage, User, id: user.id        # user can manage only his own profile
    can :manage, Post, author_id: user.id     # user can manage only his own posts
    can :manage, Comment, user_id: user.id     # user can manage only his own comments
    can :create, Like # user can create likes

    return unless user.role == 'admin'

    can :destroy, Post # admin can delete any post
    can :destroy, Comment # admin can delete any comment

    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
