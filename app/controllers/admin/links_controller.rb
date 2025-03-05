class Admin::LinksController < AdminController
  def search
    @q = Page.ransack(params[:q])
    @links = @q.result(distinct: true).order(id: :asc)
    @count = @q.result(distinct: true).count
    content = ApplicationController.render(template: "admin/links/search",
                                           layout: false,
                                           locals: { links: @links },
                                           formats: :html)
    render json: { content: content, count: @count  }
    # render layout: false
  end

  def menuitems
    # Todo: split this out into methods and neatness.
    if params[:q].include? ":"
      a = params[:q].split(":")
      if [ "Page", "Article" ].include? a[0].capitalize
        model = a[0].capitalize
      else
        model = "Page"
      end
      s = a[1]
      puts "split s: #{s}"
    else
      model = "Page"
      s = params[:q]
    end

    # puts "s: #{s} model: #{model}"
    @links =  model.constantize.where("title like ?", "%#{s}%").or(model.constantize.where("slug like ?", "%#{s}%")).order(id: :asc)
    @count = @links.count
    content = ApplicationController.render(template: "admin/links/menuitems",
                                           layout: false,
                                           locals: { links: @links },
                                           formats: :html)
    render json: { content: content, count: @count  }
  end

  def attachment
    link = Page.find(params[:id])
    content = ApplicationController.render(partial: "links/link",
                                           locals: { page: link, text: params[:text] },
                                           formats: :html)
    render json: { content: content, sgid: link.attachable_sgid }
  end
end
