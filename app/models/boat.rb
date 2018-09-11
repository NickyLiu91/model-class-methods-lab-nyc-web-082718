class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.limit(5)
  end

  def self.dinghy
    self.where('length < 20')
  end

  def self.ship
    self.where('length > 20')
  end

  def self.last_three_alphabetically
    self.order('name DESC').limit(3)
  end

  def self.without_a_captain
    self.where(captain:nil)
  end

  def self.sailboats
    boats = Arel::Table.new(:boats)
    boat_classifications = Arel::Table.new(:boat_classifications)
    classifications = Arel::Table.new(:classifications)
    # binding.pry
    id = Classification.select('id').where(name: 'Sailboat')
    boat_classifications.join(:boats).on(boat_classifications[:boat_id].eq(boats[:id])).where(classifications[:boat_id].eq('#{id}'))
    # y.where(classifications[:name].eq('Sailboat'))

  end
end
