class Admin::MenusController < AdminController
  before_action :set_item, only: [ :show, :edit, :update, :destroy ]

  def index
    @menus = Menu.all
  end

  def show
  end

  def new
    @menu = Menu.new
  end

  # GET /media/1/edit
  def edit
    # authorize @media
  end

  # PATCH/PUT /media/1
  # PATCH/PUT /media/1.json
  def update
    # authorize @media
    respond_to do |format|
      if @menu.update(menu_params)
        format.html { redirect_to edit_admin_menu_path(@menu), notice: "Menu was successfully updated." }
        format.json { render :show, status: :ok, location: @menu }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end


    def create
      @menu = Menu.new(menu_params)
      if @menu.save
         redirect_to admin_menus_path, notice: "Menu was successfully created."
      else
         render :new, status: :unprocessable_entity
      end
    end


  def destroy
    @menu.destroy
    respond_to do |format|
      format.html { redirect_to admin_menus_path, notice: "Menu deleted." }
      format.json { head :no_content }
    end
  end

  def set_item
    @menu = Menu.find(params[:id])
  end

  def menu_params
    params.require(:menu).permit(:name, :user_notification, :admin_notification, :description)
  end
end
