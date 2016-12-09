module StationsHelper
  def is_share_in_workgroup?(share, workgroup)
    if workgroup.shares.include? share
      "x"
    else
      ""
    end
  end
end
