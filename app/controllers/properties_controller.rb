class PropertiesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    render json: Property.all
  end

  def show
    property = Property.find_by(id: params[:id])
    if property
    render json: property
    else
      render json: {error: "Property not found"},status: :not_found
    end
  end
  def create
    property = @current_user.properties.create!(property_params)
    render json: property, status: :created
  end
  def update
  property = Property.find_by(id: params[:id])
    if property
    property.update(property_params)
    render json: property
    else
      render json: {error: "Property not found"},status: :not_found
    end
  end
  def increment_rating
    property = Property.find_by(id: params[:id])
    if property
      property.update(likes: property.rating + 1)
      render json: property
    else
      render json: { error: "Property not found" }, status: :not_found
    end
  end
  
  private
  def property_params
    params.require(:property).permit(:name, :value, :location, :description, :img_url, :user_id)
  end

end
