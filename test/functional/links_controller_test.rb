require 'test_helper'

class LinksControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @user = users(:one)
    sign_in(@user)
    @link = Link.create!(url: 'http://www.google.com', user: @user)
    @link_two = links(:rubysource)
  end
  context "#index" do
    context "when the latest links are requested" do
      should "return a list of the latest links" do
        get :index, format: :json
        assert json[0]["id"] = @link_two.id
      end
    end

    context "when licked links are requested" do
      setup do
        @user.licks.create!(link: @lick_two)
      end

      should "return a list of the current user's licked links" do
        get :index, format: :json, licked:true
        assert json[0]["id"] = @link_two.id
        link_one_included = false
        json.each do |l|
          link_one_included = true if l["id"] == @link.id
        end
        assert !link_one_included, "Non-licked link included"
      end
      
    end
  end

  context "#create" do
    setup do
      @link_data = links(:google).attributes
    end

    should "create a new link for the current user" do
      assert_difference lambda {@user.links.count} do
        post :create, link:@link_data, format: :json 
      end
    end
  end

  context "#destroy" do

    should "remove the link" do
      assert_difference "Link.count", -1 do
        delete :destroy, id: @link.id, format: :json      
      end
    end

    context "when the current user doesn't own the link" do
      should "respond with not found" do
        delete :destroy, id: @link_two.id, format: :json
        assert_response 404
      end
    end
  end

  context "#lick" do

    should "create a lick for the current user" do
      assert_difference lambda {@user.licks.count} do
        post :lick, format: :json, id: @link_two.id
      end
    end
  end

  context "#unlick" do
    setup do
      @user.licks.create!(link: @link_two)
    end
    should "destroy a lick for the current user" do
      assert_difference lambda {@user.licks.count}, -1 do
        post :unlick, format: :json, id: @link_two.id
      end
    end
  end
end
