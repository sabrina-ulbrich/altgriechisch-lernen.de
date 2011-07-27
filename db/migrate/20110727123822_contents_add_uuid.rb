class ContentsAddUuid < ActiveRecord::Migration
  def self.up
    add_column :contents, :uuid, :string
  end

  def self.down
    remove_column :contents, :uuid
  end
end
