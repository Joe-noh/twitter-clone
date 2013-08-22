
class Relationship < Sequel::Model
  unless table_exists?
    set_schema do
      integer :follower_id, :null => false
      integer :followee_id, :null => false
      unique [:follower_id, :followee_id]
    end
    create_table
  end
end