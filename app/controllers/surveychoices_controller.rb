class SurveychoicesController < ApplicationController
  # GET /surveychoices
  # GET /surveychoices.xml
  def index
    @surveychoices = Surveychoice.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @surveychoices }
    end
  end

  # GET /surveychoices/1
  # GET /surveychoices/1.xml
  def show
    @surveychoice = Surveychoice.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @surveychoice }
    end
  end

  # GET /surveychoices/new
  # GET /surveychoices/new.xml
  def new
    @surveychoice = Surveychoice.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @surveychoice }
    end
  end

  # GET /surveychoices/1/edit
  def edit
    @surveychoice = Surveychoice.find(params[:id])
  end

  # POST /surveychoices
  # POST /surveychoices.xml
  def create
    @surveychoice = Surveychoice.new(params[:surveychoice])

    respond_to do |format|
      if @surveychoice.save
        format.html { redirect_to(@surveychoice, :notice => 'Surveychoice was successfully created.') }
        format.xml  { render :xml => @surveychoice, :status => :created, :location => @surveychoice }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @surveychoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /surveychoices/1
  # PUT /surveychoices/1.xml
  def update
    @surveychoice = Surveychoice.find(params[:id])

    respond_to do |format|
      if @surveychoice.update_attributes(params[:surveychoice])
        format.html { redirect_to(@surveychoice, :notice => 'Surveychoice was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @surveychoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /surveychoices/1
  # DELETE /surveychoices/1.xml
  def destroy
    @surveychoice = Surveychoice.find(params[:id])
    @surveychoice.destroy

    respond_to do |format|
      format.html { redirect_to(surveychoices_url) }
      format.xml  { head :ok }
    end
  end
end
