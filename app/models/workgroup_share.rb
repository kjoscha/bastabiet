class WorkgroupShare < ActiveRecord::Base
  belongs_to :workgroup
  belongs_to :share
end
