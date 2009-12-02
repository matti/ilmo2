class CreateNewsfeeds < ActiveRecord::Migration
  # 
  # Newsfeed.create!  :message_prefix => options[:prefix],
  #                   :message_suffix => options[:suffix],
  #                   :link_to_sentence => options[:link],
  #                   :target => options[:target]
  #                   

  def self.up
    create_table :newsfeeds do |t|
      t.string :message_prefix
      t.string :message_suffix
      t.string :link_to_sentence
      
      t.references :target, :polymorphic => true
      
      t.timestamps
    end
  end
  

  def self.down
    drop_table :newsfeeds
  end
end
