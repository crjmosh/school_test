class SchoolsController < ApplicationController
	before_action :set_school, except: [:index, :new, :create]
  def index
  	@schools = School.all
  end

  def show
  end

  def new
  	@school = School.new
  end

  def create
  	@school = School.new(school_params)
  	if @school.save
  		redirect_to @school, notice: "School added successfully."
  	else
  		render :new
  	end
  end

  def edit
  end

  def update
  	if @school.update(school_params)
  		redirect_to school_path(@school), notice: "School updated successfully."
  	else
  		render :edit, alert: "School not updated!"
  	end
  end

  def destroy
  	@school.destroy
  	redirect_to schools_path, notice: "School deleted."
  end

  private

  def set_school
  	@school = School.find(params[:id])
  end

  def school_params
  	params.require(:school).permit(:name)
  end
end
