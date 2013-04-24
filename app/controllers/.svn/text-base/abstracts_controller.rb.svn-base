class AbstractsController < ApplicationController

  before_filter :authenticate_user!, :except => [:index, :new, :edit, :create, :update, :show, :keyword, :search, :submit, :verify]
  before_filter :find_attendee, :only => [:new, :create, :update, :destroy]
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
#    redirect_to :action => :submit unless @attendee
    
    @abstract = Abstract.new(:email => @attendee.email, :order_id => @attendee.order_id )
    logger.info "ATTENDEE ID: #{@attendee.id}"

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @abstract }
    end
  end

  # GET /abstracts/1/edit
  def edit
    @abstract = Abstract.find(params[:id])
    @attendee = @abstract.attendee  
  end

  # POST /abstracts
  # POST /abstracts.json
  def create
    @abstract = Abstract.new(params[:abstract])
    logger.info "ATTENDEE ID: #{@attendee.id}"
    
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
#    @abstracts_2010 = Abstract.tagged_with(params[:keyword]).where(:year => 2010).order(:position)
    
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

  def verify
    Attendee.import
  	params[:order_id].include?('-') ? order_id = params[:order_id].split('-').last : order_id = params[:order_id]     
    @attendee = Attendee.find_by_email_and_order_id(params[:email], order_id)
    
    if @attendee
      if @attendee.abstract
        redirect_to edit_abstract_url(@attendee.abstract), :notice => "Welcome back. Please update your abstract data using the form below."        
      else
        redirect_to new_abstract_url(:abstract => { :email => @attendee.email, :order_id => @attendee.order_id } ), :notice => "Great, we found your order. Please add your abstract data using the form below."
      end
    else      
      redirect_to :back, :notice => "No order found with that id and email. Are you sure that you have registered using eventbrite?"
    end
  end
  
  protected
  
  def find_attendee
    if params[:abstract] && params[:abstract][:email]
      @attendee = Attendee.find_by_email_and_order_id(params[:abstract][:email], params[:abstract][:order_id])    

      unless @attendee   
        # require an orderid+email in our db
        redirect_to submit_abstracts_url, :notice => "You must provide an order ID and email associated with your Eventbrite registration to proceed."
      else
        @attendee      
      end
    else
      # catch those that manually go to a page that requires @attendee
      redirect_to submit_abstracts_url, :notice => "You must provide an order ID and email associated with your Eventbrite registration to proceed." 
    end
  end
  
  def tag_cloud
    @keywords = Abstract.tag_counts_on(:keywords).shuffle[0..33] 
  end

end
