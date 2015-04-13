class EmployeesController < ApplicationController

  before_action :set_employee, only: [:show, :edit, :update, :destroy]
  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.search(params[:search]).page(params[:page]).per(8)
    @skills = Skill.all

  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    @skill = Skill.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)
    set_avatar

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.js
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    @employee.skills.destroy_all
    employee_find_skills
    set_avatar

    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Employee was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    Employee.destroy(params[:employees]) unless params[:employees].nil?

    respond_to do |format|
      format.html { redirect_to employees_url }
      format.json { head :no_content }
    end
  end

  def employee_vacancies
    @employee = Employee.find_by_id(params[:employee])
    @vacancies_all_prev = full_fit_vacancies(@employee)
    @vacancies_all = Kaminari.paginate_array(@vacancies_all_prev).page(params[:full_fit_page]).per(4)
    @vacancies_any_dupl = part_fit_vacancies(@employee)
    @vacancies_any = Kaminari.paginate_array(@vacancies_any_dupl - @vacancies_all_prev).page(params[:any_fit_page]).per(4)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = Employee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
      params.require(:employee).permit(:name, :email, :phone, :status, :salary, :skills, :avatar, :remove_avatar, :avatar_cache)
    end

    def skill_params
      params.require(:skill).permit(:name)
    end

    def employee_find_skills
      @skills = Skill.where(:id => params[:organizing_team])
      @employee.skills << @skills
    end

    def set_avatar
      @employee.avatar = params[:file]
    end

    
end
