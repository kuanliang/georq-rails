class ProjectsItem < ActiveRecord::Base
  belongs_to :project
  belongs_to :item
end
