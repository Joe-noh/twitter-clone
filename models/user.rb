
class User < Sequel::Model
  unless table_exists?
    set_schema do
      primary_key :id
      string :name,
             :null => false,
             :unique => true,
             :index => true
      text :self_introduction
      string :digest, :null => false
      string :salt, :null => false
    end
    create_table
  end

  one_to_many  :statuses
  many_to_many :followees,
               :class => :User,
               :join_table => :relationships,
               :left_key => :follower_id,
               :right_key => :followee_id
  many_to_many :followers,
               :class => :User,
               :join_table => :relationships,
               :left_key => :followee_id,
               :right_key => :follower_id
  many_to_one  :status,
               :join_table => :recipient

  def validate
    super
    validates_format /[\w\d]+/, :name, :message => 'must consist of A-Z, a-z, 0-9 and underscore'
    validates_unique :name
    validates_presence [:name, :digest, :salt]
  end

  def before_validation
    self.self_introduction ||= ''
  end

  def follows(user)
    self.add_followee user
  end

  def timeline
    user_ids = self.followees.map(&:id) + [self.id]
    reply_ids = Recipient.where(:recipient_id => self.id).map(&:status_id)

    Status.where(Sequel.|({:user_id => user_ids}, {:id => reply_ids})).order(Sequel.desc :created_at).all
  end
end