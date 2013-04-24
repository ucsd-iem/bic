module RegistrantsHelper
  
  def affiliation_selector(affiliation)
    case affiliation
    when nil, '', 'UC San Diego', 'National Yang-Ming University', ' '
      @html = select_tag :affiliation_selector, options_for_select(%w(\  University\ System\ Taiwan UC\ San\ Diego Other), :selected => affiliation)
    when nil
      @html = select_tag :affiliation_selector, options_for_select(%w(\  University\ System\ Taiwan UC\ San\ Diego Other), :selected => '')
    else
      @html = select_tag :affiliation_selector, options_for_select(%w(\  University\ System\ Taiwan UC\ San\ Diego Other), :selected => 'Other')
    end
  end
  
  def affiliation_toggle(affiliation)
    case affiliation
    when nil, '', 'UC San Diego', 'University System Taiwan', ' '
      @html = "style=display:none;"
    end
  end
end
