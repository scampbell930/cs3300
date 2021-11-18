module UserSignInHelpers
    def user_sign_in
        before(:each) do
            @request.env['devise.mapping'] = Devise.mappings[:user]
  
            @current_user = FactoryBot.create(:user)
            @current_user.confirm
  
            sign_in :user, @current_user
        end
    end
  end