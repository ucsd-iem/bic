require 'spec_helper'

describe Attendee do
  # object instantiation
  it { should be_an_instance_of(Attendee) }

  # association(s)
  it { should respond_to :tickets }
  it { should have_many :tickets }
end
