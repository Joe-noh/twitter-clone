
class Recipient < Sequel::Model
  unless table_exists?
    set_schema do
      integer :status_id, :null => false
      integer :recipient_id, :null => false
    end
    create_table
  end
end