class Admin::SectionsController < AdminController
  # before_action :set_site
  SECTION_TYPES = [ Blockcontent, Blockmediaset ]
  def new
    sectionable_klass = sectionables.detect { |m| params[:sectionable_type].classify.constantize == m }
    sectionable = sectionable_klass.friendly.find(params[:sectionable_id])

    @section = sectionable.sections.new()

    sectiontypeable_klass = SECTION_TYPES.detect { |m| params[:sectiontypeable_type].classify.constantize == m }
    @section.sectiontypeable =  sectiontypeable_klass.new


    # unless  sectionable.account == current_user.account
    #   redirect_to "/admin" , alert: 'Not allowed.'
    # end
  end



  def create
    @section = Section.new(
      title: section_params[:title],
      show_title: section_params[:show_title],
      template: section_params[:template],
      style: section_params[:style],
      sectionable_type: section_params[:sectionable_type],
      sectionable_id: section_params[:sectionable_id],
    )

    sectiontypeable_klass = SECTION_TYPES.detect { |m| section_params[:sectiontypeable_type].classify.constantize == m }
    sectionable_type_params = section_params.delete :sectiontypeable_attributes
    puts "sectionable_type_params:"
    puts sectionable_type_params
    @section.sectiontypeable = sectiontypeable_klass.new sectionable_type_params

    # debugger
    respond_to do |format|
      if @section.save
        format.html { redirect_to @section.sectionable.return_path, notice: "Section was successfully created." }
        format.json { render :show, status: :created, location: @section }
      else
        puts @section.errors.full_messages
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    # todo, make sure in this account! (default scope maybe)
    @section = Section.find(params[:id])
  end


  def update
    @section = Section.find(params[:id])
    sectionable_type_params = section_params.delete :sectiontypeable_attributes

    @section.sectiontypeable.update(sectionable_type_params)
    respond_to do |format|
      if @section.update(section_params)
        format.html { redirect_to edit_admin_section_path(@section), notice: "Section was successfully created." }
        format.json { render :show, status: :created, location: @section }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy

    respond_to do |format|
      format.html { redirect_to admin_pages_url, notice: "Section was successfully deleted." }
      format.json { head :no_content }
    end
  end


  def move
    @section = Section.find(params[:id])
    @section.insert_at(params[:position].to_i)
    head :ok
  end



  private
  def section_params
    # params.require(:section).permit(:sectionable_type, :sectionable_id, :title, :show_title, :template,  :style)
    params.require(:section).permit!
  end

  def sectionables
    [ Page ]
  end
end
