require 'rails_helper'

feature "When a user visits a snack show page" do
  scenario "I see name and price for that snack" do
    snack = Snack.create(name: "Flaming Hot Cheetos", price: 2.50)

    visit snack_path(snack)

    expect(page).to have_content(snack.name)
    expect(page).to have_content(snack.price)
  end

  scenario "I see a list of locations with vending machines that carry that snack" do
    snack = Snack.create(name: "Flaming Hot Cheetos", price: 2.50)
    owner = Owner.create(name: "Sam's Snacks")

    dons   = owner.machines.create(location: "Don's Mixed Drinks")
    turing = owner.machines.create(location: "Turing Basement")

    dons.snacks << snack
    turing.snacks << snack

    visit snack_path(snack)

    expect(page).to have_content("Don's Mixed Drinks")
    expect(page).to have_content("Turing Basement")
  end
  #
  # scenario "I see the average price for snacks in those vending machines" do
  #
  # end
  #
  # scenario "And I see a count of the different kinds of items in that vending machine." do
  #
  # end

end
