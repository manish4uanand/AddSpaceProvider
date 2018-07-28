class SlotsController < ApplicationController
  before_action :set_slot, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /slots
  # GET /slots.json
  def index
    @slots = Slot.all
  end

  # GET /slots/1
  # GET /slots/1.json
  def show
  end

  # GET /slots/new
  def new
    @slot = Slot.new
  end

  # GET /slots/1/edit
  def edit
  end

  # POST /slots
  # POST /slots.json
  def create
    if (slot_params[:start_time] == slot_params[:end_time] || slot_params[:start_time] > slot_params[:end_time])
      flash[:alert] = "Start Date should not be greater than or equal to End Date!"
      redirect_to new_slot_path
    else
      @slot = Slot.new(slot_params)
      @slot.created_by = current_user.id

      respond_to do |format|
        if @slot.save
          format.html { redirect_to @slot, notice: 'Slot was successfully created.' }
          format.json { render :show, status: :created, location: @slot }
        else
          format.html { render :new }
          format.json { render json: @slot.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /slots/1
  # PATCH/PUT /slots/1.json
  def update
    if (slot_params[:start_time] == slot_params[:end_time] || slot_params[:start_time] > slot_params[:end_time])
      flash[:alert] = "Start Date should not be greated than or equal to End Date!"
      render :edit
    else
      respond_to do |format|
        if @slot.update(slot_params)
          @slot.update_attribute("created_by", current_user.id)
          @slot.save
          format.html { redirect_to @slot, notice: 'Slot was successfully updated.' }
          format.json { render :show, status: :ok, location: @slot }
        else
          format.html { render :edit }
          format.json { render json: @slot.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /slots/1
  # DELETE /slots/1.json
  def destroy
    @slot.destroy
    respond_to do |format|
      format.html { redirect_to slots_url, notice: 'Slot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def book_slot
    @slot = Slot.find params[:format]
    @slot.update_attribute("booked_by", current_user.id)
    @slot.update_attribute("status", "Booked")
    
    redirect_to @slot, notice: 'Slot was booked successfully.'
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_slot
      @slot = Slot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def slot_params
      params.require(:slot).permit(:start_time, :end_time, :created_by, :booked_by)
    end
end
