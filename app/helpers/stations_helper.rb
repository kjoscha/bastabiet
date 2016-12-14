module StationsHelper
  def is_share_in_workgroup?(share, workgroup)
    if workgroup.shares.include? share
      "x"
    else
      ""
    end
  end

  def truncate(s, length = 80, ellipsis = '...')
    if s.length > length
      s.to_s[0..length].gsub(/[^\w]\w+\s*$/, ellipsis)
    else
      s
    end
  end
end
