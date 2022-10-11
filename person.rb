require 'securerandom'

class Person
  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = SecureRandom.random_number(1..100)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def can_use_services?
    @parent_permission == true || of_age? == true
  end

  attr_accessor :name, :age
  attr_reader :id

  private

  def of_age?
    @age >= 18
  end
end
