class AutoAssignmentController < ApplicationController
  before_filter :find_project, :authorize, :only => :index

  menu_item :ibs1

  def index

    @trackers_and_status_array = Hash.new

    project = Project.find(:first, 
                           :conditions => { :identifier => params[:project_id] } )

    project.trackers.each do |tracker|

      statuses_array = AdvancedStatus.get_statuses_array(tracker)

      users_array = Array.new

      statuses_array.each do |status|
        if AdvancedStatus.has_pointed_role?(status.name)
          users_array.push(AdvancedStatus.get_user_from_pointed_role(status.name, 
                                                                     project.id))
        else
          users_array.push AdvancedStatus::NO_POINTED_USER
        end
      end
      @trackers_and_status_array.store( tracker,
                                       [statuses_array, users_array] )
    end
  end
  private
  def find_project
    @project = Project.find(params[:project_id])
  end

end
