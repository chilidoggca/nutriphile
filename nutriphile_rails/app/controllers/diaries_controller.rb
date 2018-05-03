class DiariesController < ApplicationController
  # before_action :authenticate_user!
  before_action :authenticate_user!, :set_diary, only: [:show, :edit, :update, :destroy]

  # GET /diary_entries
  # GET /diary_entries.json
  def index
    @diaries = current_user.diaries.all
    respond_to do |format|
      format.html {render :index}
      format.json { render json: @diaries }
    end
  end

  # GET /diaries/1
  # GET /diaries/1.json
  def show
  end

  def date
    @date_param = params[:calendar_date]
    if @date_param
      @date_entries = current_user.diaries.where(diary_date: @date_param.to_date)
    end
  end

  # GET /diary_entries/new
  def new
    @diary = DiaryEntry.new
  end

  # GET /diary_entries/1/edit
  def edit
  end

  # POST /diary_entries
  # POST /diary_entries.json
  def create
    @diary = DiaryEntry.new(diary_params)

    respond_to do |format|
      if @diary.save
        format.html { redirect_to @diary, notice: 'Diary entry was successfully created.' }
        format.json { render :show, status: :created, location: @diary }
      else
        format.html { render :new }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diary_entries/1
  # PATCH/PUT /diary_entries/1.json
  def update
    respond_to do |format|
      if @diary.update(diary_params)
        format.html { redirect_to @diary, notice: 'Diary entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @diary }
      else
        format.html { render :edit }
        format.json { render json: @diary.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diary_entries/1
  def destroy
    @diary.destroy
    redirect_to date_path(:calendar_date => @diary.diary_date)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diary
      @diary = Diary.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diary_params
      params.require(:diary).permit(:diary_date, :meal_type, :food_name, :amount, :user_id)
    end
end
