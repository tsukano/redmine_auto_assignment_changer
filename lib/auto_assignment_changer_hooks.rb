class AutoAssignmentChangerHook < Redmine::Hook::Listener

  def controller_issues_bulk_edit_before_save(context)
    change_assignment(context)
  end
 
  def controller_issues_new_before_save(context)
    change_assignment(context)
  end
  
  def controller_issues_edit_before_save(context)
    change_assignment(context)
  end

  def change_assignment(context)
    issue = context[:issue]
    issue_db = Issue.find_by_id(issue.id)
    
    if AdvancedStatus.has_pointed_role?(issue.status.name)
      if issue_db != nil && 
         issue_db.status_id == issue.status_id &&
         issue_db.assigned_to_id != issue.assigned_to_id
        return
      end
      pointed_user = AdvancedStatus.get_user_from_pointed_role(issue.status.name, 
                                                               issue.project_id)
      issue.assigned_to_id = pointed_user.id if pointed_user.class == User
    else

      return if issue_db == nil

      if AdvancedStatus.has_pointed_role?(issue_db.status.name)
        issue.assigned_to_id = issue.author_id
      end
    end
  end
end
