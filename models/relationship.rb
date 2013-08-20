
class Relationship < Sequel::Model
  unless table_exists?
    set_schema do
      integer :follower_id, :null => false
      integer :followee_id, :null => false
    end
    create_table
  end
end