class AbstractsController < ApplicationController

  #Filter chain halted as :require_no_authentication rendered or redirected 
  before_filter :authenticate_attendee!, :except => [:index, :keyword, :search, :submit, :verify]
  before_filter :find_attendee, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :tag_cloud, :only => [:index, :keyword, :search]

  # GET /abstracts
  # GET /abstracts.json
  def index
    @abstracts = Abstract.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @abstracts }
    end
  end

  # GET /abstracts/1
  # GET /abstracts/1.json
  def show
    @abstract = Abstract.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @abstract }
    end
  end

  # GET /abstracts/new
  # GET /abstracts/new.json
  def new
    @abstract = current_attendee.abstracts.build(params[:abstract])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @abstract }
    end
  end

  # GET /abstracts/1/edit
  def edit
    @abstract = Abstract.find(params[:id])
  end

  # POST /abstracts
  # POST /abstracts.json
  def create
    @abstract = current_attendee.abstracts.build(params[:abstract])
    
    respond_to do |format|
      if @abstract.save
        format.html { redirect_to abstracts_url, notice: 'Abstract was successfully created.' }
        format.json { render json: @abstract, status: :created, location: @abstract }
      else
        format.html { render action: "new" }
        format.json { render json: @abstract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /abstracts/1
  # PUT /abstracts/1.json
  def update
    @abstract = Abstract.find(params[:id])

    respond_to do |format|
      if @abstract.update_attributes(params[:abstract])
        format.html { redirect_to abstracts_url, notice: 'Abstract was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @abstract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /abstracts/1
  # DELETE /abstracts/1.json
  def destroy
    @abstract = Abstract.find(params[:id])
    @abstract.destroy

    respond_to do |format|
      format.html { redirect_to abstracts_url }
      format.json { head :no_content }
    end
  end
    
  def keyword
    @abstracts = Abstract.tagged_with(params[:keyword])
    
    respond_to do |format|
      format.html { render action: :index}
      format.json { render json: [@abstracts] }
    end
  end
  
  def search

    respond_to do |format|
      format.html { render action: :index}
      format.json { render json: [@abstracts_2012, @abstracts_2010] }
    end    
  end

  def submit
    @attendee = Attendee.new(params[:attendee])
  end
  
  def verify
  	params[:order_id].include?('-') ? order_id = params[:order_id].split('-').last : order_id = params[:order_id]     
    @attendee = Attendee.find_by_email(params[:email])
    
    if @attendee
      if @attendee.abstracts.first
        redirect_to edit_abstract_url(@attendee.abstract), :notice => "Welcome back. Please update your abstract data using the form below."        
      else
        redirect_to new_abstract_url(:abstract => {:email => @attendee.email} ), :notice => "Great, we found your order. Please add your abstract data using the form below."
      end
    else      
      redirect_to :back, :notice => "No order found with that id and email. Are you sure that you have registered using eventbrite?"
    end
  end
  
  protected
  
  def find_attendee
    redirect_to new_attendee_session_url, :notice => "You must provide an order ID and email associated with your Eventbrite registration to proceed." unless current_attendee
  end
  
  def tag_cloud
    @keywords = Abstract.tag_counts_on(:keywords).shuffle[0..33] 
  end

end
