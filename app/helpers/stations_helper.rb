module StationsHelper
  def members_to_string(share)
    share.members.pluck(:name, :email).map { |name, email| "#{name} (#{email})" }.join(', ')
  end
end
