class Admin::UsersController < AdminController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :authenticate_admin
  layout "admin"
  # GET /admin/users or /admin/users.json
  def index
    @users = User.all.order(created_at: :desc)
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(created_at: :desc)
    @pagy, @users = pagy(@users, items: 10)
  end

  # GET /admin/users/1 or /admin/users/1.json
  def show
  end

  # GET /admin/users/new
  def new    
    @user = User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  def settings
  end

  def amend
      if current_user.update(user_params)
        redirect_to admin_settings_path, notice: "Your user-account was successfully updated."
      else
         render :settings, status: :unprocessable_entity
      end
  end

  # POST /admin/users or /admin/users.json
  def create
    @user = User.new(user_params)    
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_url, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/users/1 or /admin/users/1.json
  def update
    user_params = nil
    if params[:user][:password].blank?
      user_params = params.require(:user).permit(:first_name, :last_name,  :email, :admin, :staff, :time_zone)
    else
      user_params =  params.require(:user).permit(:first_name, :last_name, :email, :admin, :staff, :password, :time_zone)
    end
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_users_url, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1 or /admin/users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: "User was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end


  def impersonate
    user = User.find(params[:id])
    impersonate_user(user)
    redirect_to root_path
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      if User.respond_to?(:admin_params)
        params.require(:user).permit(*User.admin_params)
      else
        params.require(:user).permit(:first_name, :last_name, :email, :site_admin, :staff, :password, :time_zone, :debug, :account_id)
      end
    end
end
