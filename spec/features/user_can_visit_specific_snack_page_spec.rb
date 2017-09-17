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

  scenario "I see the average price for snacks in those vending machines and snack count" do
    snack1 = Snack.create(name: "Flaming Hot Cheetos", price: 2.50)
    snack2 = Snack.create(name: "Doritos", price: 2.50)
    snack3 = Snack.create(name: "Brownies", price: 2.50)
    snack4 = Snack.create(name: "Tuna Sandwich", price: 3.50)

    owner = Owner.create(name: "Sam's Snacks")

    dons   = owner.machines.create(location: "Don's Mixed Drinks")
    turing = owner.machines.create(location: "Turing Basement")

    dons.snacks << [snack1, snack2, snack3]
    turing.snacks << [snack4, snack1]

    visit snack_path(snack1)

    expect(page).to have_content("Don's Mixed Drinks (3 kinds of snacks, average price of $2.50)")
    expect(page).to have_content("Turing Basement (2 kinds of snacks, average price of $3.00)")
  end

end
