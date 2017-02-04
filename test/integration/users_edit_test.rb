require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = ""
    email = "foo@invlaid"
    pword = "foo"
    pword_conf = "bar"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password: pword,
                                              password_confirmation: pword_conf } }

    assert_select 'div.alert', text: "The form contains 4 errors."
    assert_template 'users/edit'
  end
  
  test "successful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    name = "Name"
    email = "foo@valid.com"
    pword = pword_conf = ""
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password: pword,
                                              password_confirmation: pword_conf } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
    
end