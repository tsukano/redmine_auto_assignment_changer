class AdvancedStatus

  NO_POINTED_USER = ''
  NOT_FINDED_USER = '[担当無し]'
  NO_ROLE = '[ロール無し]'

  def self.get_statuses_array(tracker)
    statuses_array = Array.new
    tracker.workflows.each do |workflow|
      unless statuses_array.include? workflow.old_status
        statuses_array.push workflow.old_status
      end
    end
    statuses_array.sort!{|status_x, status_y| status_x.position <=> status_y.position}
  end

  def self.has_pointed_role?(status_name)
    status_name =~ /^.+＠.+$/
  end

  def self.get_role_name(status_name)
    status_name.sub(/^.+＠/, "")
  end

  def self.get_user_from_pointed_role(status_name, project_id)
    role = Role.find(:first,
                     :conditions => {:name => get_role_name(status_name) } )
    return NO_ROLE if role == nil
    role.members.each do |member|
      if member.project_id == project_id
        return member.user
      end
    end
    return NOT_FINDED_USER
  end

end
