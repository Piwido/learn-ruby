# module ControllerMacros
#   def login_admin(test_case)
#     test_case.instance_eval do
#       @request.env["devise.mapping"] = Devise.mappings[:admin]
#       sign_in FactoryBot.create(:admin)
#     end
#   end
#
#   def login_user(test_case)
#     test_case.instance_eval do
#       @request.env["devise.mapping"] = Devise.mappings[:user]
#       user = FactoryBot.create(:user)
#       sign_in user
#     end
#   end
# end
