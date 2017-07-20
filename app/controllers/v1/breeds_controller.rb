class V1::BreedsController < ApplicationController
  before_action :authenticate_request!, except: [:index, :show]

  def index
    @breeds = Breed.all
    name = params[:name]
    @breeds = Breed.name_search(name)
    # origin = params[:origin]
    # @breeds = Breed.origin(origin)
    json_response(@breeds.page(params[:page]))

  end

  def show
    @breed = Breed.find(params[:id])
    json_response(@breed)
  end

  def create
    if @breed = Breed.create!(breed_params)
      json_response(@breed, :created)
    else
      render status: 422, json: {
        message: "create breed failed"
      }
    end
  end

  def update
    @breed = Breed.find(params[:id])
    if  @breed.update!(breed_params)
      render status: 200, json: {
        message: "breed successfully updated"
      }
    else
      render status: 503, json: {
        message: "service not available"
      }
    end
  end

  def destroy
    @breed = Breed.find(params[:id])
    if @breed.destroy
      render status: 200, json: {
        message: "breed destroyed"
      }
    else
      render status: 503, json: {
        message: "service not available"
      }
    end
  end

  private

  def breed_params
    params.permit(:name, :origin, :common_name, :characteristics, :image, :fun_fact, :variations, :history)
  end

end
