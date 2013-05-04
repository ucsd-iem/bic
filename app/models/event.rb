class Event < ActiveRecord::Base
  attr_accessible :location, :start, :stop, :title, :moderator_ids
  # has_many :abstracts
  # has_many :moderators
  validates :start, :presence => true
  validates :stop, :presence => true

  Romans = { 1 => "I", 2 => "II", 3 => "III",  4 => "IV", 5 => "V", 6 => "VI" }

  scope :on_wednesday, lambda {  where("start < ?", DateTime.new(2013,6,20)+7.hours).order("start ASC") }
  scope :on_thursday, lambda {  where("start > ? AND stop < ?", DateTime.new(2013,6,20)+7.hours, DateTime.new(2013,6,21)+7.hours).order("start ASC") }
  scope :on_friday, lambda {  where("start > ?", DateTime.new(2013,6,21)+7.hours).order("start ASC") }
  
  def name
    "#{self.id} - #{self.title} - #{self.start}"
  end
  
  def dynamic_title
#e    case
#    when self.abstract
#      @title = self.abstract.title
#    else
      @title = self.title
#    end
#    @title = "#{self.start.strftime("%m/%d %l:%M") if self.start} #{"SESSION #{Romans[self.session]}: " unless self.moderators.empty?}#{@title}"
  end
  
  # returns the time of day in which the program starts for this event
  def start_of_day
    
  end
  
  # returns the time of day in which the program ends for this event
  def end_of_day
    
  end
  
  # returns true if this event is the first of the day
  def first_of_day?
    
  end
  
  # returns true if this event is the last of the day
  def last_of_day?
    
  end
  
  # returns an array of alternate events that exist during the given event's time period for for the specific time range
  def alternate_events(range = self.start..self.stop)
    Event.where("id != ? AND start <= ? AND stop <= ? AND stop >= ? ", self.id, range.end, range.end, range.end).order("location ASC")
  end
  
  # returns duration of event in hours
  def duration
    self.stop - self.start
  end

  def moderators_data
  #  case 
  #  when self.moderators.count > 1
  #    "<span class='moderator_label'>Moderators</span> #{self.moderators.collect {|e| e.name}.join(', ')}"
  #  when self.moderators.count == 1
  #    "<span class='moderator_label'>Moderator</span> #{self.moderators.first.name}"
  #  when self.moderators.count == 0
  #    nil
  #  end
  end
  
  def list_data(time)
    html = "<div class='e_#{self.id} t_#{time.strftime('%H_%M')} event_data'>"
 
    html << "#{self.title}<br />" if self.title 
    html << "#{self.location}<br />" if self.location
    #html << "#{self.moderators_data}" if self.moderators

    html << "</div>"
        
    html
  end
  
  def title_row?(time)
    (self.start-time).abs < 60 || (self.start-time).abs == 900
  end
  
  def normal_row?(time)
    !self.title_row?(time) && !self.end_row?(time)
  end

  def end_row?(time)
    case self.stop - time
    when 1800.seconds
      true
    when 900.seconds
      true
    when -900.seconds
      true
    else
      false
    end      
  end
  
  # does this row start 15 minutes after the hour?
  def quarter_start?(time)
    self.start.strftime('%M') == '15' && self.title_row?(time)
  end

  # does this row start 45 minutes after the hour?
  def quarter_before_start?(time)
    self.start.strftime('%M') == '45' && self.title_row?(time)
  end
  
  # does this row end 15 minutes early?
  def quarter_end?(time)
    self.title_row?(time) && (self.stop.strftime('%M') == '15' || self.stop.strftime('%M') == '45')
  end  
  
  ###
  ### CLASS METHODS
  ###
  
  class << self
  
    # returns the time of day in which the program starts for this event
    def start_of_day(events)
      start = events.first.start
      events.map { |e| start = e.start if e.start < start }
      start
    end

    # returns the time of day in which the program ends for this event
    def end_of_day(events)
      stop = events.first.stop
      events.each { |e| stop = e.stop if e.stop > stop }
      stop
    end
    
    def range(events)
      raise "You gotta give me some events if you want a range, perhaps I should just give you nil in return?" if events.nil?
      Event.start_of_day(events)..Event.end_of_day(events)
    end

    def time_slots_15(events)
      range = Event.range(events)
      width = Event.width(events)

      time_slots = []

      time = range.begin

      while time <= (range.end+1.minute) do
        time_slots << time
        time += + 15.minutes
      end
      
      time_slots.sort
    end

    def list_row(time)
      # if any events start during this time?      
      if events = Event.where(:start => time)
      
        list_row = ''
        
        if events.count > 1
          time_groups = []
          events.each do |e|
            if time_groups.first && time_groups.first.first.stop == e.stop
              time_groups.first << e
            else
              time_groups << [e]
            end
          end
          
          time_groups.each do |tg|
            list_row << "<tr><td class='list_time'>#{tg.first.start.strftime('%I:%M')} - #{tg.first.stop.strftime('%I:%M %p')}</td>"
          
            list_row << "<td class='event_row'>"
            tg.each do |tg_event|
              list_row << "<div class='event_block_multiple'>"
              list_row << "#{tg_event.title}<br />"
              list_row << "#{tg_event.location if tg_event.location}<br />"
              # list_row << "#{tg_event.moderators_data if tg_event.moderators.exists?}"
              list_row << "</div>"
            end
            list_row << '</td>'
          end
          
        else
          events.each do |e|
            list_row << "<tr><td class='list_time'>#{e.start.strftime('%I:%M')} - #{e.stop.strftime('%I:%M %p')}</td>"
        
            list_row << "<td class='event_row'>"
            list_row << "<div class='event_block'>"
            list_row << e.title + "<br />"  if e.title
            list_row << e.location + "<br />" if e.location
            # list_row << e.moderators_data if e.moderators.exists?
            list_row << "</div>"
            list_row << '</td>'
          end
        end # if events.count > 1
        
        list_row
      end # events = Event.where(:start => time)
    end 
    
    # returns the maximum
    def width(events)
      max_width = 0
      events.map { |e| max_width = e.alternate_events.count if e.alternate_events.count > max_width }
      max_width + 1
    end

    alias_method :max_simutaneous, :width
    
  end
  
  
  
end