# frozen_string_literal: true

class AuditLogsController < ApplicationController
  before_action :set_audit_log, only: [:show, :edit, :update, :destroy]

  def index
    authorize AuditLog
    @audit_logs = policy_scope(AuditLog).includes(:user).page(params[:page]).per(10)
  end

  def show
    authorize @audit_log
  end

  def new
    @audit_log = AuditLog.new
    authorize @audit_log
  end

  def edit
    authorize @audit_log
  end

  def create
    @audit_log = current_user.audit_logs.new(audit_log_params)
    authorize @audit_log

    # respond_to do |format|
    #   if @audit_log.save
    #     format.html { redirect_to @audit_log, notice: "Audit log was successfully created." }
    #     format.json { render :show, status: :created, location: @audit_log }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @audit_log.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def update
    authorize @audit_log
    respond_to do |format|
      if @audit_log.update(audit_log_params)
        format.html { redirect_to @audit_log, notice: "Audit log was successfully updated." }
        format.json { render :show, status: :ok, location: @audit_log }
      else
        # format.html { render :edit }
        # format.json { render json: @audit_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @audit_log
    # @audit_log.destroy
    # respond_to do |format|
    #   format.html { redirect_to audit_logs_url, notice: "Audit log was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private
    def set_audit_log
      @audit_log = AuditLog.find(params[:id])
    end

    def audit_log_params
      params.require(:audit_log).permit(:status)
    end
end
