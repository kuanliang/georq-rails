class Account::ProjectsController < ApplicationController
  #before_action :authenticate_user!
 
  def index
    
        @date = params[:month] ? Date.parse(params[:month]) : Date.today
    @newdate=@date+1.year
    @newdate2=@date+2.year
    @olddate=@date-1.year

    @olddate2=@date-2.year
    @audits=Audit.all.selected_month(@date)
    @audits_report=Audit.all.selected_month_report(@date).where(:certification_body => "Royalcert")

    @projects = Project.all.selected_month(@date)
    @items_projects=ItemsProject.all.selected_month(@date)
    
    @consultant_classes = ConsultantClass.all.selected_month(@date)
    
    @consultants = Consultant.all
    @tasks = Project.this_month
    
    @certificates=Certificate.all.expiration_selected_month(@date)

    @last_year_certificates=Certificate.all.expiration_selected_month(@newdate)

    @last_2_year_certificates=Certificate.all.expiration_selected_month(@newdate2)
   
@allcertificates= @certificates+@last_year_certificates+@last_2_year_certificates


    @last_year_audits=Audit.all.selected_month(@olddate)
    @last_2_year_audits=Audit.all.selected_month(@olddate2)
    @alloldaudits=@last_year_audits#+@last_2_year_audits

    #@customers = Customer.joins(:customers_tags,:tags).where('tag_name LIKE ?', "#{params[:tag]}").distinct
    #@auditmonth = @date.month
    #@customers=Customer.joins(:audit_months_customers,:audit_months,:projects,:audits,:certificates).where(audit_months_customers: {audit_month_id: @date.month}).where(:stop => false)
     #<% Customer.joins(:tags,:projects,:audits).distinct.where(audits: {:certificate_send_date => @date.beginning_of_month..@date.end_of_month}).where(tags: {follow: true}).where(tags: {tag_name: t.tag_name}).find_each do |c| %>
   
  end

end
