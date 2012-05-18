require 'unit/test_helper'
require 'models/user'
require 'interactors/find_user'

describe FindUser do

  it "exists" do
    FindUser.new.wont_be_nil
  end

  it "can find a user by a login token of the given type" do
    user = User.new
    user.set_login_token :web, "token"
    Repository.for(User).save user

    action = FindUser.new
    found = action.by_login_token :web, "token"

    found.must_equal user
  end

  it "keeps different login tokens seperate" do
    user = User.new
    user.set_login_token :web, "token"

    user2 = User.new
    user2.set_login_token :api, "token"

    Repository.for(User).save user
    Repository.for(User).save user2

    action = FindUser.new
    found = action.by_login_token :api, "token"

    found.must_equal user2
  end

end