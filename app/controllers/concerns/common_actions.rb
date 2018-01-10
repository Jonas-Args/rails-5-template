module CommonAction
  extend ActiveSupport::Concern

  included do
    before_action :find_obj, except: [:index,:create,:search,:all]
  end

  def index
    obj_klass =  eval(resource_name)
    render json: obj_klass.all
  end

  def create
    @obj = eval(resource_name).new(obj_params)
    if @obj.save
      render_obj
    else
      obj_errors
    end
  end

  def show
    render_obj
  end

  def update
    if @obj.update_attributes(obj_params)
      render_obj
    else
      obj_errors
    end
  end

  def destroy
    if @obj.destroy
      render_success
    else
      obj_errors
    end
  end

  protected

  def find_obj
    @obj = eval(resource_name).where(id: params[:id]).first
  end

end
