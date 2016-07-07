class AddGetMoneyPeopledateToItemProjects < ActiveRecord::Migration
  def change
  	add_column :items_projects, :get_money_people , :string
  	add_column :items_projects, :get_money_date , :date
  end
end
