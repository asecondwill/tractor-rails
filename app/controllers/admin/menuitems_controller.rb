class Admin::MenuitemsController < AdminController
  before_action :set_menuitem, only: [  :edit, :update, :destroy, :move ]

  def create
    @menu = Menu.find(params[:menu_id])
    @menuitem = @menu.menuitems.new(menuitem_params)
    if @menuitem.save
       redirect_to admin_menu_path(@menuitem.menu), notice: "Item created."
    else
       render template: "admin/menus/show", status: :unprocessable_entity
    end
  end

  def edit
      @menu = @menuitem.menu
  end

  def update
    @menu = @menuitem.menu
    respond_to do |format|
      if @menuitem.update(menuitem_params)
        format.html { redirect_to admin_menu_path(@menu), notice: "Item updated." }
        format.json { render :show, status: :ok, location: @menu }
      else
        format.html {
          render template: "admin/menus/show", status: :unprocessable_entity
        }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  def move
    @menuitem = Menuitem.find(params[:id])
    if params[:ancestry] == "undefined"
      @menuitem.update_columns(ancestry:  nil)
    else
      @menuitem.update_columns(ancestry:  params[:ancestry])
    end
    @menuitem.insert_at(params[:position].to_i)
    head :ok
  end

  def destroy
    @menuitem.destroy
    respond_to do |format|
      format.html { redirect_to admin_menu_path(@menuitem.menu), status: :see_other, notice: "Item deleted." }
      format.json { head :no_content }
    end
  end

  private
  def set_menuitem
    @menuitem = Menuitem.find(params[:id])
  end
  def menuitem_params
    params.require(:menuitem).permit(:name, :menu_id, :link, :menuitemable_id, :menuitemable_type, :style, :strap)
  end
end
