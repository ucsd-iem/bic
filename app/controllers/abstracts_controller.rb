class AbstractsController < ApplicationController

  #Filter chain halted as :require_no_authentication rendered or redirected 
  before_filter :authenticate_attendee!, :except => [:index, :keyword, :search, :show, :submit, :verify]
  before_filter :tag_cloud, :only => [:index, :keyword, :search, :show]

  # GET /abstracts
  # GET /abstracts.json
  def index
    @abstracts = Abstract.order('created_at DESC').page params[:page]

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
        format.html { redirect_to @abstract, notice: 'Abstract was successfully created.' }
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
        format.html { redirect_to @abstract, notice: 'Abstract was successfully updated.' }
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
    @abstracts = Abstract.tagged_with(params[:keyword]).page params[:page]
    
    respond_to do |format|
      format.html { render action: :index}
      format.json { render json: [@abstracts] }
    end
  end
    
  protected
  
  # tag clound consisting of the top 34 keywords sorted by name
  def tag_cloud
    @keywords = Abstract.tag_counts_on(:keywords).sort_by { |keyword| keyword.count }.reverse[0..33].sort_by { |keyword| keyword.name }
  end

end
