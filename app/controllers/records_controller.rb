class RecordsController < ApplicationController
  def index
    @records = policy_scope(Record)
  end

  def create
    @record = current_user.records.build(record_params)
    @record.name = current_user.email
    if @record.save
      render json: @record
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  def update
    @record = Record.find(params[:id])
    if @record.update(record_params)
      render json: @record
    else
      render json: @record.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @record = Record.find(params[:id])
    authorize @record
    @record.destroy
    head :no_content
  end

  private

    def record_params
      params.require(:record).permit(:title, :amount, :date, :isHours)
    end
end
