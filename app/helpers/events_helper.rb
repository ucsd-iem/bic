module EventsHelper
  
  def abbreviate(string)
    abbreviated_words = { "Institue of Engineering in Medicine" => "IEM", "Departments of" => "Depts.", "Department of" => "Dept.", "Institute of" => "Inst."}
    
    abbreviated_words.each do |k,v|
      string = string.gsub(k,v)
    end
    string
  end
  
  def build_table(events)
    html = ''
    row = 1
    Event.time_slots(events).map {|t| html << Event.table_row(t, row, Event.width(events)); row += 1 }
    raw(html)
  end
  
  def build_list(events)
    html = ''
    Event.time_slots_15(events).map {|t| html << Event.list_row(t) }
    raw(html)
  end
  
end
