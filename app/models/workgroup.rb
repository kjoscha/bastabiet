class Workgroup < ActiveRecord::Base
  has_many :workgroup_shares, dependent: :destroy  
  has_many :shares, through: :groupings

  def self.add_existant
    [
      'Willkommens-AG',
      'Finanz-AG',
      'Internet-AG',
      'Landkauf-AG',
      'Plenums-AG',
      'Rechtsform-AG',
      'Soli-AG',
      'Brot-AG',
      'Eier-AG',
      'Betreuung der Ida',
      'Betreuung der K9',
      'Betreuung der Brauni',
      'Hoffest-Crew',
    ].each do |w|
      Workgroup.new(name: w).save
    end
  end
end
