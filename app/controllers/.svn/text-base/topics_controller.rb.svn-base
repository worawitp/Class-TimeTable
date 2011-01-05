class TopicsController < ApplicationController
  # GET /topics
  # GET /topics.xml
  def index
    @topics = Topic.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.xml
  def show
    @user = session[:user]
    if params[:forum_id]
      @forum = params[:forum_id]
    end
    @topic = Topic.find(params[:id])
    @comments = Comment.find_all_by_topic_id(@topic.id, :order => "comment_number")
    @comment=Comment.new
    @survey = Survey.find_by_topic_id(@topic.id)
    if(@survey)
      @voted=false
      @choices=@survey.surveychoices
      for choice in @choices
        found = Vote.find_by_sql("select * from votes where surveychoice_id="+choice.id.to_s+" and owner_id="+@user.id.to_s)
        if found[0]
          @voted=true
        end
      end

      @vote=Vote.new
    end

    #@max=@comments[@comments.length-1].comment_number

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/new
  # GET /topics/new.xml
  def new
    @user = session[:user]
    @topic = Topic.new
    if params[:forum_id]
      @forums = Forum.find_all_by_id(params[:forum_id])
    else
      @forums = Forum.all
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @topic }
    end
  end

  # GET /topics/1/edit
  def edit
    @user = session[:user]
    @topic = Topic.find(params[:id])
    if params[:forum_id]
      @forums = Forum.find_all_by_id(params[:forum_id])
    else
      @forums = Forum.all
    end
  end

  # POST /topics
  # POST /topics.xml
  def create
    if params[:makeup_class]
      @topic = Topic.new(params[:topic])
      @topic.owner_id = params[:owner_id]
      @topic.description=params[:description]
      course_id = params[:course_id]
      forum = Forum.find_by_name("Makeup Class")
      if !forum
        forum = Forum.new
        forum.name="Makeup Class"
        forum.course_id=course_id
        forum.save
      end


      forum.topics.push @topic
      forum.save


      survey=Survey.new
      survey.topic_id=@topic.id
      survey.save

      params[:num][:choices].to_i.times { |i|
        survey_choice=Surveychoice.new
        survey_choice.choice_number=i
        survey_choice.content=params["datepicker"+(i+1).to_s]+" "+params["timeslot"+(i+1).to_s][:starttime] + " - "+params["timeslot"+(i+1).to_s][:endtime]
        #survey_choice.content = i
        survey.surveychoices.push survey_choice


        #surveychoice=Surveychoice.new
        #surveychoice.content="test"
        #surveychoice.choice_number=(i+1)
        ##surveychoice.survey_id=survey.id
        #surveychoice.save
        #survey.surveychoices.push surveychoice
      }


      survey.save

      respond_to do |format|
        if forum.save
          format.html { redirect_to(forum, :notice => 'Topic was successfully created.') }
          format.xml  { render :xml => @topic, :status => :created, :location => @topic }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
        end
      end

    else
      @topic = Topic.new(params[:topic])
      if params[:survey]="on"
        @survey = Survey.new
        @topic.survey=@survey
        params[:num][:choices].to_i.times { |i|
          survey_choice=Surveychoice.new
          survey_choice.choice_number=i
          survey_choice.content = params["choice"+(i+1).to_s]
          @survey.surveychoices.push survey_choice
        }
      end

      respond_to do |format|
        if @topic.save
          format.html { redirect_to(@topic, :notice => 'Topic was successfully created.') }
          format.xml  { render :xml => @topic, :status => :created, :location => @topic }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # PUT /topics/1
  # PUT /topics/1.xml
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to(@topic, :notice => 'Topic was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.xml
  def destroy
    @topic = Topic.find(params[:id])
    forum_id = @topic.forum_id
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to(forum_url(forum_id)) }
      format.xml  { head :ok }
    end
  end
end
