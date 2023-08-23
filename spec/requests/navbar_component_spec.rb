RSpec.describe "Navigation", type: :request do
  describe "GET root_path" do
    it "displays the navigation bar" do
      visit root_path

      expect(page).to have_selector("img", class: "block h-8 w-auto")

      expect(page).to have_link("Home", href: root_path(locale: "en"))
      expect(page).to have_link("Rooms", href: rooms_path(locale: "en"))
      expect(page).to have_link("Contact", href: contact_path(locale: "en"))

      if @user.present?
        if @user.is_superadmin?
          expect(page).to have_link("Super Admin", href: admin_dashboard_hotels_path)
        elsif @user.is_admin?
          expect(page).to have_link("Admin", href: admin_dashboard_hotels_path)
        elsif @user.is_manager?
          expect(page).to have_link("Manager", href: manager_dashboard_path)
        end

        expect(page).to have_button("Sign out", href: destroy_user_session_path)
      else
        expect(page).to have_link("Login", href: new_user_session_path(locale: "en"))
      end

      expect(page).to have_link("English", href: root_path(locale: :en))
      expect(page).to have_link("Serbian", href: root_path(locale: :sr))
    end
  end
end
