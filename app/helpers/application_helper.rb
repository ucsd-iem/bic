module ApplicationHelper
  
  def abstract_deadline
    DateTime.new(2013,5,3,17,15).change(offset: '-0700')
  end
  
  def right_content
    @html = ''
    @html << '<h1>Sponsors</h1>'
    @html
  end
end
