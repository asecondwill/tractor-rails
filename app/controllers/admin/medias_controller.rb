class Admin::MediasController < AdminController
  before_action :set_media, only: [:update]
  include Pagy::Backend
    before_action :authorize_access!

    def index
      @attaching = false
      @q = Media.ransack(params[:q])

      @medias = @q.result(distinct: true)      
      @pagy, @medias = pagy(@medias, items: 10)
    end

    def attach      
      @medias=Media.all
      @controllername=params["controller_name"]
      @controllerselector=params["controller_selector"]
      render :layout => false
     
    end

    def new
      @media = Media.new
    end

    def create
      @media = Media.new(media_params)
      if @media.save
        redirect_to admin_medias_path, notice: 'Media was successfully created.'                  
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
      @media = Media.find(params[:id])
    end

    def show
      @blob = ActiveStorage::Blob.find(params[:id])
    end

    def destroy
      puts "destroy #{params[:id]}"
      @media= Media.find(params[:id])
      @media.destroy
      redirect_to admin_medias_path
    end

    def update                    
      respond_to do |format|
        if @media.update(media_params)
          format.html { redirect_to edit_admin_media_path(@media), notice: 'Media was successfully updated.' }
          format.json { render :show, status: :ok, location: @media }
        else
          format.html { render :edit , status: :unprocessable_entity}
          format.json { render json: @media.errors, status: :unprocessable_entity }
        end
      end
    end


    private

   
    def set_media
      @media = Media.find(params[:id])      
    end

    def media_params
      params.require(:media).permit(:name, :alt, :title, :file)
    end

    def authorize_access!
      # check site config from 
      #raise_404 if Avo::MediaLibrary.configuration.disabled?
    end
end