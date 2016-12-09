module StationsHelper
  def workgroup_names(share)
    share.workgroups.pluck(:name).join(', ')
  end
end
