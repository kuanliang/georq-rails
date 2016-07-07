class AuditMonthController < ApplicationController

 before_action :authenticate_user!, only: [:new,:index, :edit, :create, :update, :destroy] 

	def index

    	@date = params[:month] ? Date.parse(params[:month]) : Date.today
		@auditmonth = @date.month
 		@customers=Customer.joins(:audit_months_customers,:audit_months).where(audit_months_customers: {audit_month_id: @date.month}).where(:stop => false).distinct
	end



end
