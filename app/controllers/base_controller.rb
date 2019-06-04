class BaseController < ApplicationController
  def create
    render :errors, status: 409 unless resource.save
  end

  def destroy
    resource.destroy
    head 204
  end

  def update
    render :errors, status: 409 unless resource.update(resource_params)
  end
end
