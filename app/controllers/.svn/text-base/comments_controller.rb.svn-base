class CommentsController < ApplicationController
  # GET /comments
  # GET /comments.xml
  def index
    @comments = Comment.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @user = session[:user]

    @max=0
    @comment = Comment.new
    if params[:topic_id]
      @topics = Topic.find_all_by_id(params[:topic_id])
      @max=Comment.find_by_sql("select max(comment_number) as maxnum from comments where topic_id="+params[:topic_id])[0].maxnum
    else
      @topics = Topic.all
    end
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  # POST /comments.xml
  def create
    @comment = Comment.new(params[:comment])
    max=Comment.find_by_sql("select max(comment_number) as maxnum from comments where topic_id="+params[:comment][:topic_id])[0].maxnum
    @comment.comment_number=max.to_i+1

    respond_to do |format|
      if @comment.save
        format.html { redirect_to( {:controller => "topics", :action => "show", :id => params[:comment][:topic_id]}, :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /comments/1
  # PUT /comments/1.xml
  def update
    @comment = Comment.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        format.html { redirect_to(@comment, :notice => 'Comment was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @comment = Comment.find(params[:id])
    topic_id = @comment.topic_id
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to(topic_url(:id => topic_id)) }
      format.xml  { head :ok }
    end
  end
end
