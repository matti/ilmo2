xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Ilmo 2.0 newsfeed"
    xml.description "Latest cool happenings at ilmo 2.0"
    xml.link root_url

    for item in @newsfeed
      xml.item do
        xml.title "#{item.message_prefix} #{item.message_suffix} #{item.target.name}"
        xml.pubDate item.created_at.to_s(:rfc822)
        xml.link root_url
      end
    end
  end
end
