class AppsController < ApplicationController
  before_action :set_app, only: [:show, :edit, :update, :destroy]

  # GET /apps
  # GET /apps.json
  def index
    @apps = App.all
  end

  # GET /apps/1
  # GET /apps/1.json
  def show
#    @categories = ("1".."7").to_a
#    @data = [5, 6, 3, 1, 2, 4, 7]
    @rankings = @app.ranking_last(7)

    @prev = @next = nil
    begin
      @prev = App.find(@app.id - 1)
    rescue
    end
    begin
      @next = App.find(@app.id + 1)
    rescue
    end

    @data = @rankings.collect { |r| r.position }.reverse
    @categories = @rankings.collect { |r| r.created_at.strftime('%m/%d') }.reverse

    @h = LazyHighCharts::HighChart.new("graph") do |f|
      f.chart(:type => "line")
      f.title(:text => "Week Ranking")
      f.xAxis(:categories => @categories)
      f.yAxis(:max => @data.max+1,
              :min => 0,
              :reversed => true,
              :minTickInterval => 1,
              :allowDecimals => false,
              :title => {:text => "rank" })
      f.series(:name => "rank",
               :data => @data)
    end
  end

  # GET /apps/new
  def new
    @app = App.new
  end

  # GET /apps/1/edit
  def edit
  end

  # POST /apps
  # POST /apps.json
  def create
    @app = App.new(app_params)

    respond_to do |format|
      if @app.save
        format.html { redirect_to @app, notice: 'App was successfully created.' }
        format.json { render action: 'show', status: :created, location: @app }
      else
        format.html { render action: 'new' }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /apps/1
  # PATCH/PUT /apps/1.json
  def update
    respond_to do |format|
      if @app.update(app_params)
        format.html { redirect_to @app, notice: 'App was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @app.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.json
  def destroy
    @app.destroy
    respond_to do |format|
      format.html { redirect_to apps_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_app
      @app = App.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def app_params
      params.require(:app).permit(:name, :developer, :img_url, :detail_url)
    end
end
