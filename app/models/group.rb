class Group < ActiveRecord::Base
  belongs_to :stations
  has_many :shares, dependent: :destroy  

  validates_length_of :name, minimum: 3, allow_blank: false

  def shares_count
    shares.map(&:size).sum
  end

  def completion
    shares_count / 4 * 100
  end

  def total_offer_minimum
    shares.map(&:total_offer_minimum).sum
  end

  def total_offer_medium
    shares.map(&:total_offer_medium).sum
  end

  def total_offer_maximum
    shares.map(&:total_offer_maximum).sum
  end

  def self.add_existant
    ida = Station.create(name: 'Ida Nowhere')
    %w[
      bouffe
      kladaradatsch
      banana_split
      gurken
      juni_2
      loveboat
      luftplankton
      mai_2
      newyork_cheesecake
      buklearhokkaido
    ].each do |group|
      ida.groups.build(name: group.humanize.upcase).save
    end

    brauni = Station.create(name: 'Brauni')
    %w[
      beetbox
      fuenf_minuten
      jitomate
      kaesehunde
      knoeterich
      krasse_kresse
      lischen_radieschen
      mallorca
      rhabarberbarbaras
    ].each do |group|
      brauni.groups.build(name: group.humanize.upcase).save
    end

    k9 = Station.create(name: 'Kinziger 9')
    %w[
      banana
      basiliko
      bombasta
      estragon
      fagioli
      funbert
      gurkentruppe
      hortus
      pastinake
      rot_schwarz_k9
    ].each do |group|
      k9.groups.build(name: group.humanize.upcase).save
    end
  end
end
