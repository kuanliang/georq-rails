class RemoveClassDateFromConsultantClass < ActiveRecord::Migration
  def change
  	change_column :consultant_classes, :class_date, :date
  end
end
