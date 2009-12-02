module NewsfeedHelper
  
  def format_newsfeed_item(item)
    link_to_target = link_to(item.link_to_sentence, item.target) if item.link_to_sentence
    
    return "#{item.message_prefix}#{link_to_target}#{item.message_suffix}"
  end 
  
end