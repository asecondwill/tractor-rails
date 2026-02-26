class <%= controller_class_name %> < AdminController
  before_action :set_<%= singular_table_name %>, only: %i[ show edit update destroy ]

  def index
    @<%= plural_table_name %> = <%= class_name %>.all
  end

  def show
  end

  def new
    @<%= singular_table_name %> = <%= class_name %>.new
  end

  def edit
  end

  def create
    @<%= singular_table_name %> = <%= class_name %>.new(<%= singular_table_name %>_params)

    respond_to do |format|
      if @<%= singular_table_name %>.save
        format.html { redirect_to [:admin, @<%= singular_table_name %>], notice: "<%= human_name %> was successfully created." }
        format.json { render :show, status: :created, location: [:admin, @<%= singular_table_name %>] }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @<%= singular_table_name %>.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @<%= singular_table_name %>.update(<%= singular_table_name %>_params)
        format.html { redirect_to [:admin, @<%= singular_table_name %>], notice: "<%= human_name %> was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: [:admin, @<%= singular_table_name %>] }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @<%= singular_table_name %>.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @<%= singular_table_name %>.destroy!
    respond_to do |format|
      format.html { redirect_to admin_<%= plural_table_name %>_path, status: :see_other, notice: "<%= human_name %> was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_<%= singular_table_name %>
    @<%= singular_table_name %> = <%= class_name %>.find(params[:id])
  end

  def <%= singular_table_name %>_params
    params.require(:<%= singular_table_name %>).permit(<%= attributes.map { |attr| ":#{attr.name}" }.join(', ') %>)
  end
end