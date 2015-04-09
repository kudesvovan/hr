class VacanciesController < ApplicationController
  before_action :set_vacancy, only: [:show, :edit, :update, :destroy]

  # GET /vacancies
  # GET /vacancies.json
  def index
    @vacancies = Vacancy.search(params[:search]).paginate(:page => params[:page], :per_page => 8)
  end

  # GET /vacancies/1
  # GET /vacancies/1.json
  def show
  end

  # GET /vacancies/new
  def new
    @vacancy = Vacancy.new
  end

  # GET /vacancies/1/edit
  def edit
  end

  # POST /vacancies
  # POST /vacancies.json
  def create
    @vacancy = Vacancy.new(vacancy_params)
    @skills = Skill.where(:id => params[:organizing_team])
    @vacancy.skills << @skills

    respond_to do |format|
      if @vacancy.save
        format.html { redirect_to @vacancy, notice: 'Vacancy was successfully created.' }
        format.json { render :show, status: :created, location: @vacancy }
      else
        format.html { render :new }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vacancies/1
  # PATCH/PUT /vacancies/1.json
  def update
    @vacancy = Vacancy.find(params[:id])
    @skills = Skill.where(:id => params[:organizing_team])
    @vacancy.skills.destroy_all
    @vacancy.skills << @skills
    respond_to do |format|
      if @vacancy.update(vacancy_params)
        format.html { redirect_to @vacancy, notice: 'Vacancy was successfully updated.' }
        format.json { render :show, status: :ok, location: @vacancy }
      else
        format.html { render :edit }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vacancies/1
  # DELETE /vacancies/1.json
  def destroy
    @vacancy.destroy
    respond_to do |format|
      format.html { redirect_to vacancies_url, notice: 'Vacancy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    Vacancy.destroy(params[:vacancies]) unless params[:vacancies].nil?

    respond_to do |format|
      format.html { redirect_to vacancies_url }
      format.json { head :no_content }
    end
  end

  def vacancy_employees
    @vacancy = Vacancy.find_by_id(params[:vacancy])
    @employees_all = full_fit_employees(@vacancy)
    @employees_any = part_fit_employees(@vacancy)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vacancy
      @vacancy = Vacancy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vacancy_params
      params.require(:vacancy).permit(:name, :date_in, :date_up, :salary, :contacts, :skills)
    end
end
