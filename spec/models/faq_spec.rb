require 'spec_helper'

describe Faq do
  # object instantiation
  it { should be_an_instance_of(Faq) }

  # association(s)
  it { should respond_to :question }
  it { should respond_to :answer }
  it { should respond_to :position }
  
end
