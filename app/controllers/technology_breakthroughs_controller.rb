class TechnologyBreakthroughsController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:index, :show, :new]

  def index
    if params[:company_id]
      @technology_breakthroughs = TechnologyBreakthrough.where(company_id: params[:company_id])
    else
      @technology_breakthroughs = TechnologyBreakthrough.all
    end
  end

  def new
    company = Company.find_by(id: params[:company_id])
    @technology_breakthrough = company.technology_breakthroughs.build
  end

  def create
    @technology_breakthrough = TechnologyBreakthrough.new(technology_breakthrough_params)

    if @technology_breakthrough.save
      redirect_to company_technology_breakthrough_path(@technology_breakthrough.company, @technology_breakthrough)
    else
      render :new
    end
  end

  def show
    company = Company.find_by(id: params[:company_id]) or render_404
    @technology_breakthrough = company.technology_breakthroughs.find_by(id: params[:id]) or render_404
  end

  def edit
    company = Company.find_by(id: params[:company_id]) or render_404
    @technology_breakthrough = company.technology_breakthroughs.find_by(id: params[:id]) or render_404
  end

  def update
    company = Company.find_by(id: params[:company_id]) or render_404
    @technology_breakthrough = company.technology_breakthroughs.find_by(id: params[:id]) or render_404
    @technology_breakthrough.update(technology_breakthrough_params)

    redirect_to company_technology_breakthrough_path(@technology_breakthrough.company, @technology_breakthrough)
  end

  def destroy

  end

  private
    def technology_breakthrough_params
      params.require(:technology_breakthrough).permit(:name, :description, :year, :company_id)
    end
end
