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
    result = {
      "id"          => obj.id, 
      "text"        => name,
      "parent"      => parent,
      "icon"        => "string",
      "state"       => {
        "opened"    => true,  
      },
      "li_attr"     => {},
      "a_attr"      => {}  
    }
    return result
  end
end
