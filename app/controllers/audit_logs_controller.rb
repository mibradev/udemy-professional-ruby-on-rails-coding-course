# frozen_string_literal: true

class AuditLogsController < ApplicationController
  before_action :set_audit_log, only: [:show, :edit, :update, :destroy]
  before_action -> { authorize AuditLog }

  def index
    @audit_logs = policy_scope(AuditLog).includes(:user)
  end

  def show
  end

  def new
    @audit_log = AuditLog.new
  end

  def edit
  end

  def create
    @audit_log = current_user.audit_logs.new(audit_log_params)

    respond_to do |format|
      if @audit_log.save
        format.html { redirect_to @audit_log, notice: "Audit log was successfully created." }
        format.json { render :show, status: :created, location: @audit_log }
      else
        format.html { render :new }
        format.json { render json: @audit_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @audit_log.update(audit_log_params)
        format.html { redirect_to @audit_log, notice: "Audit log was successfully updated." }
        format.json { render :show, status: :ok, location: @audit_log }
      else
        format.html { render :edit }
        format.json { render json: @audit_log.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @audit_log.destroy
    respond_to do |format|
      format.html { redirect_to audit_logs_url, notice: "Audit log was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_audit_log
      @audit_log = AuditLog.find(params[:id])
    end

    def audit_log_params
      params.require(:audit_log).permit(:status, :start_date, :end_date)
    end
end
