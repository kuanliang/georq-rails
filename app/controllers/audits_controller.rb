class AuditsController < ApplicationController
	 before_action :authenticate_user!, only: [:index,:new, :edit, :create, :update, :destroy]
   respond_to :html
def waitaudit
     @q= Audit.where("real_audit_date > ?",Time.zone.now.to_s(:db)).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q])
     @waitaudit_q = Audit.where("real_audit_date > ?",Time.zone.now.to_s(:db)).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q])
     @waitgetreport_q =Audit.where("real_audit_date < ?  and report_get_date is ? ",Time.zone.now.to_s(:db),nil   ).where("report_send_date is ?",nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q]) #.where("report_send_date = ?",nil) .where.not("report_get_date = ?",nil)
     @waitreport_q= Audit.where("real_audit_date < ?  and report_get_date <= ? ",Time.zone.now.to_s(:db),Time.zone.now.to_s(:db)   ).where("report_send_date is ?",nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q]) #.where("report_send_date = ?",nil) .where.not("report_get_date = ?",nil)
     @waitcertificate_q= Audit.where("real_audit_date<?  and certificate_get_date is ? ",Time.zone.now.to_s(:db),nil).where.not("report_send_date is ?", nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q])
     @waitsendcertificate_q= Audit.where("real_audit_date < ? and certificate_send_date is ? ",Time.zone.now.to_s(:db),nil).where.not("certificate_get_date is ?", nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q])
      @audits=@waitaudit_q.result.distinct#.paginate(:page => params[:page])#.page(params[:page]) 
     
      respond_with @audits   
end
def waitgetreport
     @q= Audit.where("real_audit_date < ?  and report_get_date is ? ",Time.zone.now.to_s(:db),nil   ).where("report_send_date is ?",nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q]) #.where("report_send_date = ?",nil) .where.not("report_get_date = ?",nil)
    
     @waitaudit_q = Audit.where("real_audit_date > ?",Time.zone.now.to_s(:db)).ransack(params[:q])
     @waitgetreport_q =Audit.where("real_audit_date < ?  and report_get_date is ? ",Time.zone.now.to_s(:db),nil   ).where("report_send_date is ?",nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q]) #.where("report_send_date = ?",nil) .where.not("report_get_date = ?",nil)
     @waitreport_q= Audit.where("real_audit_date < ?  and report_get_date <= ? ",Time.zone.now.to_s(:db),Time.zone.now.to_s(:db)   ).where("report_send_date is ?",nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q]) #.where("report_send_date = ?",nil) .where.not("report_get_date = ?",nil)
     @waitcertificate_q= Audit.where("real_audit_date < ? and certificate_get_date is ? ",Time.zone.now.to_s(:db),nil).where.not("report_send_date is ?", nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q])
      @waitsendcertificate_q= Audit.where("real_audit_date < ? and certificate_send_date is ? ",Time.zone.now.to_s(:db),nil).where.not("certificate_get_date is ?", nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q])
      @audits=@waitgetreport_q.result.distinct#.paginate(:page => params[:page])#.page(params[:page]) 
     
      respond_with @audits 
end
def waitreport
      @q=Audit.where("real_audit_date < ?  and report_get_date <= ? ",Time.zone.now.to_s(:db),Time.zone.now.to_s(:db)   ).where("report_send_date is ?",nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q]) #.where("report_send_date = ?",nil) .where.not("report_get_date = ?",nil)
   
      @waitaudit_q = Audit.where("real_audit_date > ?",Time.zone.now.to_s(:db)).ransack(params[:q])
     @waitgetreport_q =Audit.where("real_audit_date < ?  and report_get_date is ? ",Time.zone.now.to_s(:db),nil   ).where("report_send_date is ?",nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q]) #.where("report_send_date = ?",nil) .where.not("report_get_date = ?",nil)
     @waitreport_q= Audit.where("real_audit_date < ?  and report_get_date <= ? ",Time.zone.now.to_s(:db),Time.zone.now.to_s(:db)   ).where("report_send_date is ?",nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q]) #.where("report_send_date = ?",nil) .where.not("report_get_date = ?",nil)
     @waitcertificate_q= Audit.where("real_audit_date < ? and certificate_get_date is ? ",Time.zone.now.to_s(:db),nil).where.not("report_send_date is ?", nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q])
      @waitsendcertificate_q= Audit.where("real_audit_date < ? and certificate_send_date is ? ",Time.zone.now.to_s(:db),nil).where.not("certificate_get_date is ?", nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q]) 
      @audits=@waitreport_q.result.distinct#.paginate(:page => params[:page])#.page(params[:page]) 
     
      respond_with @audits  
end
def waitcertificate
       @q=Audit.where("real_audit_date<? and certificate_get_date is ? ",Time.zone.now.to_s(:db),nil).where.not("report_send_date is ?", nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q])
        #Audit.where("real_audit_date < ?  and report_get_date <= ? ",Time.zone.now.to_s(:db),Time.zone.now.to_s(:db)   ).where("report_send_date is ?",nil).ransack(params[:q]) #.where("report_send_date = ?",nil) .where.not("report_get_date = ?",nil)
   
      @waitaudit_q = Audit.where("real_audit_date > ?",Time.zone.now.to_s(:db)).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q])
      @waitgetreport_q =Audit.where("real_audit_date < ?  and report_get_date is ? ",Time.zone.now.to_s(:db),nil   ).where("report_send_date is ?",nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q]) #.where("report_send_date = ?",nil) .where.not("report_get_date = ?",nil)
      @waitreport_q= Audit.where("real_audit_date < ?  and report_get_date <= ? ",Time.zone.now.to_s(:db),Time.zone.now.to_s(:db)   ).where("report_send_date is ?",nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q]) #.where("report_send_date = ?",nil) .where.not("report_get_date = ?",nil)
      @waitcertificate_q= Audit.where("real_audit_date < ? and certificate_get_date is ? ",Time.zone.now.to_s(:db),nil).where.not("report_send_date is ?", nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q])
      @waitsendcertificate_q= Audit.where("real_audit_date < ? and certificate_send_date is ? ",Time.zone.now.to_s(:db),nil).where.not("certificate_get_date is ?", nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q])
      @audits=@waitcertificate_q.result.distinct.paginate(:page => params[:page])#.page(params[:page]) 
     
      respond_with @audits  
end
def waitsendcertificate
     @q=Audit.where("real_audit_date<? and certificate_send_date is ? ",Time.zone.now.to_s(:db),nil).where.not("certificate_get_date is ?", nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q])
        #Audit.where("real_audit_date < ?  and report_get_date <= ? ",Time.zone.now.to_s(:db),Time.zone.now.to_s(:db)   ).where("report_send_date is ?",nil).ransack(params[:q]) #.where("report_send_date = ?",nil) .where.not("report_get_date = ?",nil)
   
      @waitaudit_q = Audit.where("real_audit_date > ?",Time.zone.now.to_s(:db)).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q])
      @waitgetreport_q =Audit.where("real_audit_date < ?  and report_get_date is ? ",Time.zone.now.to_s(:db),nil   ).where("report_send_date is ?",nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q]) #.where("report_send_date = ?",nil) .where.not("report_get_date = ?",nil)
      @waitreport_q= Audit.where("real_audit_date < ?  and report_get_date <= ? ",Time.zone.now.to_s(:db),Time.zone.now.to_s(:db)   ).where("report_send_date is ?",nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q]) #.where("report_send_date = ?",nil) .where.not("report_get_date = ?",nil)
      @waitcertificate_q= Audit.where("real_audit_date < ? and certificate_get_date is ? ",Time.zone.now.to_s(:db),nil).where.not("report_send_date is ?", nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q])
      @waitsendcertificate_q= Audit.where("real_audit_date < ? and certificate_send_date is ? ",Time.zone.now.to_s(:db),nil).where.not("certificate_get_date is ?", nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q])
      @audits=@waitsendcertificate_q.result.distinct.paginate(:page => params[:page])#.page(params[:page]) 
     
      respond_with @audits
  
end

def sendreport

    @audit=Audit.find(params[:id])
    @audit.sendreport()
      flash[:notice] = "標記成功"
    #id=params[:format]
    #@customer = Customer.find(params[:id])
    #redirect_to certificates_path()
    redirect_to audits_path()
   # redirect_to customers_path()

end

def getreport

    #@certificate = Certificate.find(params[:id])
    @audit=Audit.find(params[:id])
    @audit.getreport()
      flash[:notice] = "標記成功"
    #id=params[:format]
    #@customer = Customer.find(params[:id])
    #redirect_to certificates_path()
    redirect_to audits_path()
   # redirect_to customers_path()

end

def import
          
                if params[:file].blank?
                  
                    redirect_to audits_path() ,notice: '請選擇檔案'
                else
                    #Customer.from_csv!(csv_file)
                Audit.import(params[:file])
                   redirect_to audits_path(), notice: "Audits imported."
                end
  end 

 def advanced_search
    @q = Audit.ransack(params[:q])
    #@search.build_grouping unless @search.groupings.any?
    @audits = @q.result.paginate(:page => params[:page])#.page(params[:page])
#respond_with @audits
    respond_to @audits
   
 end

  def index
     @waitaudit_q = Audit.where("real_audit_date > ?",Time.zone.now.to_s(:db)).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q])
     @waitgetreport_q =Audit.where("real_audit_date < ?  and report_get_date is ? ",Time.zone.now.to_s(:db),nil   ).where("report_send_date is ?",nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q]) #.where("report_send_date = ?",nil) .where.not("report_get_date = ?",nil)
     @waitreport_q= Audit.where("real_audit_date < ?  and report_get_date <= ? ",Time.zone.now.to_s(:db),Time.zone.now.to_s(:db)   ).where("report_send_date is ?",nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q]) #.where("report_send_date = ?",nil) .where.not("report_get_date = ?",nil)
      @waitcertificate_q= Audit.where("real_audit_date < ? and certificate_get_date is ? ",Time.zone.now.to_s(:db),nil).where.not("report_send_date is ?", nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q])
     @waitsendcertificate_q= Audit.where("real_audit_date < ? and certificate_send_date is ? ",Time.zone.now.to_s(:db),nil).where.not("certificate_get_date is ?", nil).where.not("status = ?" ,"已完成(顧客確認)").ransack(params[:q])
    #@audits = Audit.search(params[:audit_type]).page params[:page]
    # @q = Audit.ransack(params[:q])
     #@audits = @q.result(distinct: true).page(params[:page])
#{}"created_at >= :start_date AND created_at <= :end_date", {start_date: params[:start_date], end_date: params[:end_date]})project_contract_start_date_start
     # date_range = params[:contract_start_date_start]..params[:contract_start_date_end]
     # .joins(:project).where(project: {contract_start_date: date_range})
#Client.joins(:orders).where(orders: {created_at: time_range})
      @q = Audit.ransack(params[:q])
      #Client.joins(:orders).where('orders.created_at' => time_range)
      #@q = Audit.includes(:project).where("project_contract_start_date >= ? ",'2016' ).ransack(params[:q])
      ##@q = Audit.ransack(params[:q])
      #@c = @q.join(:customer)
      @audits=@q.result.distinct.paginate(:page => params[:page])#.page(params[:page]) 
      #@audits.include(:projects).include(:customers)
    #if params[:audit_type]
       respond_with @audits    
     # @audits = Audit.where('audit_type LIKE ? ', "%#{params[:audit_type]}%")
               
   # else
            


     # @search = Search.new(Audit, params[:search], :per_page => 10)
      #@search.order = 'email'  # optional
      #@audits = @search.run



      #@audits = Audit.all.order(real_audit_date: :desc)
    #end
      if false
      respond_to do |format|
      format.html
      format.csv {

            filename = "Audits-#{Time.now.strftime("%Y%m%d%H%M%S")}.csv"
                #@customers.to_csv
            send_data(@audits.to_csv, :type => "text/xls; charset=utf-8; header=present",:filename => filename)
          }
          format.xls {send_data @audits.to_csv(col_sep: "\t")}
        end

      end


    @tags = Tag.all
  end
def show
    @customer = Customer.find(params[:customer_id])

    @project = Project.find(params[:project_id])
    @audit = Audit.find(params[:id])
    @type = params[:type]
    @date =  Date.today
    @certificate=@audit.certificate
end



   
  def new

 	@customer = Customer.find(params[:customer_id])

    @project = Project.find(params[:project_id])


    @services = Service.all
    @audit = @project.audits.new
    #@certificate=@audit.certificate.build
 end
 
 def edit

    @services = Service.all
    @customer = Customer.find(params[:customer_id])
  	@project = Project.find(params[:project_id])
    @audit = @project.audits.find(params[:id])
 end
 
 def create
 	@customer = Customer.find(params[:customer_id])
 	@project = Project.find(params[:project_id])
    @audit = @project.audits.build(audit_params)
 
    if @audit.save
      redirect_to customer_project_path(@customer,@project), notice: "新增成功！"
      #redirect_to account_consultants_path, notice: "新增專案成功！"
    else
      render :new
    end
 end
 
 def update
 	 @customer = Customer.find(params[:customer_id])	
 	@project = Project.find(params[:project_id])
    @audit = @project.audits.find(params[:id])
 
    if @audit.update(audit_params)
      #redirect_to customer_project_path(@customer,@project), notice: "修改成功！"
      #redirect_to customer_path(@customer), notice: "修改成功！"
       redirect_to :back, notice: "修改客戶資料成功"
    else
      render :edit
    end
 end
 
 def destroy
 	
 	 @customer = Customer.find(params[:customer_id])
 	@project = Project.find(params[:project_id])
    @audit = @project.audits.find(params[:id])
 
    @audit.destroy
    redirect_to customer_project_path(@customer,@project), alert: "專案已刪除"
 end
    private
   
    def audit_params
      params.require(:audit).permit(:lead_auditor_stg2_id,:auditor2_stg2_id,:auditor1_stg2_id,:auditor2_id,:auditor_id,:lead_auditor_id,:project_id,:lead_auditor_stg2,:auditor1_stg2,:auditor2_stg2,:specialist_stg2,:train_auditor_stg2,:man_day_stg2,:prepare_opendate_stg2,:prepare_closedate_stg2,:audit_opendate_stg2,:audit_closedate_stg2,:real_auditor,:audit_name,:parent_audit_id,:brother_audit_id,:service_id,:certification_body, :CB_number, :audit_type, :audit_standard, :EA_CODE, :ISO9000_exclusions, :man_day, :scope_chi, :scope_eng, :address1_chi, :address1_eng, :address2_chi, :address2_eng, :address3_chi, :address3_eng, :address4_chi, :address4_eng, :lead_auditor, :auditor, :auditor2, :specialist, :train_auditor, :prepare_opendate, :prepare_closedate, :audit_opendate, :audit_closedate, :comment, :real_audit_date, :real_audit_time, :report_get_date, :report_send_date, :certificate_get_date, :certificate_send_date, :status)
    end
end

    