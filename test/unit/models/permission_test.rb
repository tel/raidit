require 'unit/test_helper'
require 'models/permission'
require 'models/user'
require 'models/guild'

describe Permission do

  it "is an entity" do
    Permission.ancestors.must_include Entity
  end

  it "is linked to a user" do
    user = User.new
    p = Permission.new user: user
    p.user.must_equal user
  end

  it "can be linked to a guild" do
    guild = Guild.new
    p = Permission.new guild: guild
    p.guild.must_equal guild
  end

  it "has a list of permissions" do
    p = Permission.new
    p.permissions.must_equal []
  end

  it "lets passing in of initial permissions" do
    p = Permission.new permissions: [:accept, :deny]
    p.permissions.must_equal [:accept, :deny]
  end

  it "can be asked for an empty permission set for given user and guild" do
    user = User.new
    guild = Guild.new

    empty_permission = Permission.empty(user, guild)
    empty_permission.permissions.must_equal []
    empty_permission.user.must_equal user
    empty_permission.guild.must_equal guild
  end

  describe "#allow" do
    it "adds a new permission to the list" do
      p = Permission.new
      p.allow :perm1
      p.permissions.must_equal [:perm1]
    end

    it "prevents duplicates" do
      p = Permission.new
      p.allow :perm1
      p.allow :perm1
      p.allow :perm1
      p.permissions.must_equal [:perm1]
    end
  end

  describe "#allows?" do
    it "checks for existence of requested permission" do
      p = Permission.new
      p.allow :perm1

      p.allows?(:perm1).must_equal true
    end

    it "returns false if permission not found" do
      p = Permission.new
      p.allows?(:perm1).must_equal false
    end
  end
end
