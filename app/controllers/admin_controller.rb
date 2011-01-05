class AdminController < ApplicationController
  require_role 'admin'
  before_filter :login_required

  def index
    @user=session[:user]
    @all_users=User.find(:all, :order => "created_at DESC")
    time_now = Time.new

    @number_reg_user_today=0
    @number_reg_user_this_week=0
    @number_reg_user_this_month=0
    for user in @all_users
      time_diff = (time_now - user.created_at)/(60*60*24)
      if time_diff < 1
        @number_reg_user_today +=1
      end
      if time_diff < 7
        @number_reg_user_this_week +=1
      end
      if time_diff < 30
        @number_reg_user_this_month +=1
      end

    end
  end

  def showuser
    if params[:id]
      @user=User.find_by_id(params[:id])
      if @user==nil
        flash[:error]="Error : cannot find the specific user"
      end
    else
      @user=nil
      flash[:error]="Error : cannot find the specific user"
    end
  end

  def banuser
    if params[:id]
      @user=User.find_by_id(params[:id])
      if @user==nil
        flash[:error]="Error : cannot find the specific user"
      else
        @user.suspend!
        flash[:notice]="User: "+@user.login+" is suspended"
      end
    else
      @user=nil
      flash[:error]="Error : cannot find the specific user"
    end
    redirect_back_or_default(:action => "showuser", :id => @user.id)
  end

  def unbanuser
    if params[:id]
      @user=User.find_by_id(params[:id])
      if @user==nil
        flash[:error]="Error : cannot find the specific user"
      else
        @user.unsuspend!
        flash[:notice]="User: "+@user.login+" is unsuspended"
      end
    else
      @user=nil
      flash[:error]="Error : cannot find the specific user"
    end
    redirect_back_or_default(:action => "showuser", :id => @user.id)
  end

  def deleteuser
    if params[:id]
      @user=User.find_by_id(params[:id])
      if @user==nil
        flash[:error]="Error : cannot find the specific user"
      else
        @user.delete!
        @user.destroy
        flash[:notice]="User: "+@user.login+" is deleted"
      end
    else
      @user=nil
      flash[:error]="Error : cannot find the specific user"
    end
    redirect_back_or_default(:action => "index")
  end

  protected
  def find_user_by_id(id)
    @user=User.find_by_id(id)
  end
end
