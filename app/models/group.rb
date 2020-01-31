class Group < ActiveRecord::Base
  belongs_to :station
  has_many :shares, dependent: :destroy

  validates_length_of :name, minimum: 3, allow_blank: false
  validates :name, uniqueness: true

  def super_moneymaker_email
    shares
      .find_by(super_moneymaker: true)
      &.share_moneymaker
      &.email
  end

  def shares_with_offer
    shares.find_all do |share|
      share.offer_minimum
    end
  end

  def total_size_of_shares_with_offer
    shares_with_offer.map(&:size).sum
  end

  def register_completion
    shares.map(&:size).sum / 4 * 100
  end

  def offer_completion
    total_size_of_shares_with_offer / 4 * 100
  end

  def total_offer_minimum
    shares.map(&:offer_minimum).compact.sum
  end

  def total_offer_medium
    shares.map(&:offer_medium).compact.sum
  end

  def total_offer_maximum
    shares.map(&:offer_maximum).compact.sum
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
      nuklearhokkaido
      zucchini
      zweitopf
      runkelruebchen
      zazaza
      topinambur
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
      basiliko
      bombasta
      estragon
      fagioli
      funbert
      gurkentruppe
      hortus
      pastinake
      rot_schwarz_k9
      travolta
      machen_wa_noch
    ].each do |group|
      k9.groups.build(name: group.humanize.upcase).save
    end

    woennich = Station.create(name: 'woennich')
    %w[
      woennich_103
    ].each do |group|
      woennich.groups.build(name: group.humanize.upcase).save
    end
  end
end
