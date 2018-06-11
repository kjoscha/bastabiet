class Workgroup < ActiveRecord::Base
  has_many :workgroup_shares, dependent: :destroy
  has_many :shares, through: :workgroup_shares

  def self.add_existant
    Workgroup.delete_all
    [
      'Internet-AG',
      'Landkauf-AG',
      'Plenums-AG',
      'Rechtsform-AG',
      'Soli-AG',
      'Hoffest-AG',
      'Stadt-AG',
      'Willkommens-AG',
      'AG Abholstation Ida',
      'AG Abholstation Bödie',
      'AG Abholstation Brauni',
    ].each do |w|
      Workgroup.new(name: w).save
    end
  end
end
