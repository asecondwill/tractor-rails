class Admin::PagesController < AdminController
  before_action :set_page, only: %i[ show edit update destroy ]

  # GET /admin/pages or /admin/pages.json
  def index
    @pages = Page.all        
  end

  # GET /admin/pages/1 or /admin/pages/1.json
  def show
  end

  # GET /admin/pages/new
  def new
    @page = Page.new
  end

  # GET /admin/pages/1/edit
  def edit
  end

  # POST /admin/pages or /admin/pages.json
  def create
    @page = Page.new(page_params)

    respond_to do |format|
      if @page.save
        format.html { redirect_to edit_admin_page_path(@page), notice: "Page was successfully created." }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/pages/1 or /admin/pages/1.json
  def update
    respond_to do |format|
      if @page.update(page_params)
        @page.destroy_attachment("banner", page_params)
        format.html { redirect_to edit_admin_page_path(@page), notice: "Page was successfully updated." }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/pages/1 or /admin/pages/1.json
  def destroy
    @page.destroy

    respond_to do |format|
      format.html { redirect_to admin_pages_url, notice: "Page was successfully destroyed." }
      format.json { head :no_content }
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.friendly.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def page_params
      params.require(:page).permit(:title, :slug, :content, :banner, :banner_destroy, :description, :show_title, :template, :banner_text, :published)
    end
end
