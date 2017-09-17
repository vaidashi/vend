require 'rails_helper'

feature 'When a user visits a vending machine show page' do
  scenario 'they see the location of that machine' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
  end

  scenario 'I see the name of all of the snacks associated with that vending machine along with their price' do
    owner = Owner.create(name: "Sam's Snacks")
    dons  = owner.machines.create(location: "Don's Mixed Drinks")
    snack = Snack.create(name: "Doritos", price: 1.0)
    dons.snacks << snack

    visit machine_path(dons)

    expect(page).to have_content("Don's Mixed Drinks Vending Machine")
    expect(page).to have_content("Doritos")
    expect(page).to have_content(1.0)
  end
end
