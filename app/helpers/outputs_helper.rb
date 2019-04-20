module OutputsHelper
  
  require 'json'
  
  def jrtree_hash objs
    result = {}
    result['core'] = {}
    result['core']['data'] = []
    
    objs.each do |obj|
      result['core']['data'] << (jrtree_entry obj)
    end
    return result
  end
  def jrtree_entry obj
    if obj.parent
      parent = obj.parent_id
    else
      parent = "#"
    end
    
    name = User.find_by_id(obj.user_id).name
    img = gravatar(User.find_by_id(obj.user_id), size: 20)
    result = {
      "id"          => obj.id, 
      "text"        => name,
      "parent"      => parent,
      "icon"        => img,
      "state"       => {
        "opened"    => true,  
      },
      "li_attr"     => {},
      "a_attr"      => {"href" => output_path(obj.id)}  
    }
    return result
  end
  
  def gravatar(user, options = { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    return gravatar_url
  end
  
end
