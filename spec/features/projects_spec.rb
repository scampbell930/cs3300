require 'rails_helper'
require 'factory_bot_rails'

RSpec.feature "Projects", type: :feature do
  context "Create new project" do
    before(:each) do
      visit new_project_path
      within("form") do
        user = FactoryBot.create(:user, email: "email@email.com", password: "123456")
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        #fill_in "Password confirmation", with: user.password
        click_on "Log in"
      end
      within("form") do
        fill_in "Title", with: "Test title"
      end
    end

    scenario "should be successful" do
      fill_in "Description", with: "Test description"
      click_button "Create Project"
      expect(page).to have_content("Sean's Portfolio\nHome email@email.com Log out\nTest title\nTest description\nEdit | Back")
    end

    scenario "should fail" do
      click_button "Create Project"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Update project" do
    
    before(:each) do
      # Create projet before update
      visit new_project_path
      within("form") do
        user = FactoryBot.create(:user, email: "email@email.com", password: "123456")
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        #fill_in "Password confirmation", with: user.password
        click_on "Log in"
      end
      within("form") do
        fill_in "Title", with: "Test title"
        fill_in "Description", with: "Test description"
        click_button "Create Project"
      end
      click_link "Edit"
    end

    scenario "should be successful" do
      within("form") do
        fill_in "Description", with: "New description content"
      end
      click_button "Update Project"
      expect(page).to have_content("Sean's Portfolio\nHome email@email.com Log out\nTest title\nNew description content\nEdit | Back")
    end

    scenario "should fail" do
      within("form") do
        fill_in "Description", with: ""
      end
      click_button "Update Project"
      expect(page).to have_content("Description can't be blank")
    end
  end

  context "Remove existing project" do
    before(:each) do
      # Create projet before update
      visit new_project_path
      within("form") do
        user = FactoryBot.create(:user, email: "email@email.com", password: "123456")
        fill_in "Email", with: user.email
        fill_in "Password", with: user.password
        #fill_in "Password confirmation", with: user.password
        click_on "Log in"
      end
      within("form") do
        fill_in "Title", with: "Test title"
        fill_in "Description", with: "Test description"
        click_button "Create Project"
      end
      click_link "Back"
    end
    scenario "remove project" do
      visit projects_path
      click_link "Destroy"
      expect(page).to have_content("Project was successfully destroyed")
      expect(Project.count).to eq(0)
    end
  end
end