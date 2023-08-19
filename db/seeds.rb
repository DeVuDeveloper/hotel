module SeedData
  include FactoryBot::Syntax::Methods

  FactoryBot.create(:user)
  hotel = FactoryBot.create(:hotel)

  3.times do
    FactoryBot.create(:room)
  end
 