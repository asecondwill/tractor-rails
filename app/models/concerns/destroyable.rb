module Destroyable
  extend ActiveSupport::Concern
  included do
    # per record
    def destroy_attachment(attchment_name, params)
      if params["#{attchment_name}_destroy"].to_i == 1 && !params[attchment_name].present?
        send(attchment_name).purge
      end
    end
  end

  class_methods do
    # you know, for the class.  like searches
  end
end