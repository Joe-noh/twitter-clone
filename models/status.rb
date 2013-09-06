
class Status < Sequel::Model

  unless table_exists?
    set_schema do
      primary_key :id
      integer :user_id,
              :null => false,
              :index => true
      text :text, :null => false
      datetime :created_at,
               :null => false,
               :unique => true
    end
    create_table
  end

  many_to_one :user
  many_to_many :recipients,
               :class => :User,
               :join_table => :recipients

  def validate
    super
    validates_presence [:text, :created_at]
    validates_max_length 200, :text
  end

  def before_validation
    self.created_at ||= Time.now
    super
  end

  def extract_recipients
    self.text.scan(/@([\w\d]+)/)
  end
end