require 'rails_helper'
require  'factory_girl'
require File.expand_path('../spec_helper', File.dirname(__FILE__))

RSpec.describe User, type: :model do


    def should_be_validated(user, password, message = "Password is invalid")
      assert(user.valid_ldap_authentication?(password), message)
    end

    def should_not_be_validated(user, password, message = "Password is not properly set")
       assert(!user.valid_ldap_authentication?(password), message)
    end

    describe "With default settings" do
      before do
        default_devise_settings!
        reset_ldap_server!
      end

      describe "look up an ldap user" do
        it "should return true for a user that does exist in LDAP" do
          assert_equal true, ::Devise::LDAP::Adapter.valid_login?('example.user@johnny.com')
        end

        it "should return false for a user that doesn't exist in LDAP" do
          assert_equal false, ::Devise::LDAP::Adapter.valid_login?('barneystinson')
        end
      end

      describe "create a basic user" do
        before do
          @user = FactoryGirl.create(:user)
        end

        it "should check for password validation" do
          assert_equal(@user.email, "example.user@test.com")
          should_be_validated @user, "secret"
          should_not_be_validated @user, "wrong_secret"
          should_not_be_validated @user, "Secret"
        end
      end
    end

    describe 'Connection' do
    it 'accepts a proc for ldap_config' do
      ::Devise.ldap_config = Proc.new() {{
        'host' => 'localhost',
        'port' => 3389,
        'base' => 'ou=tech,dc=johnny,dc=com',
        'attribute' => 'cn',
      }}
      connection = Devise::LDAP::Connection.new()
      expect(connection.ldap.base).to eq('ou=tech,dc=johnny,dc=com')
    end
  end

  describe "use username builder" do
    before do
      default_devise_settings!
      reset_ldap_server!
      ::Devise.ldap_auth_username_builder = Proc.new() do |attribute, login, ldap|
        "#{attribute}=#{login},ou=others,dc=johnny,dc=com"
      end
      @other = FactoryGirl.create(:other)
    end
    it "should be able to authenticate" do
     should_be_validated @other, "other_secret"
   end
  end

  describe "create a basic user" do
     before do
       @user = FactoryGirl.create(:user)
     end

     it "should check for password validation" do
       assert_equal(@user.email, "example.user@test.com")
       should_be_validated @user, "secret"
       #should_not_be_validated @user, "wrong_secret"
       #should_not_be_validated @user, "Secret"
     end
end
end
