module PagesHelper
  def tagline_truncated_mission_statement(sponsor)
    sponsor.tagline.blank? ? sponsor.mission_statement.truncate(96, :separator => ' ') : sponsor.tagline
  end
end
