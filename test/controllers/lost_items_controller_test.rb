require 'test_helper'

class LostItemsControllerTest < ActionController::TestCase
  setup do
    @lost_item = lost_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lost_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lost_item" do
    assert_difference('LostItem.count') do
      post :create, lost_item: { location: @lost_item.location, returned: @lost_item.returned, when: @lost_item.when }
    end

    assert_redirected_to lost_item_path(assigns(:lost_item))
  end

  test "should show lost_item" do
    get :show, id: @lost_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lost_item
    assert_response :success
  end

  test "should update lost_item" do
    patch :update, id: @lost_item, lost_item: { location: @lost_item.location, returned: @lost_item.returned, when: @lost_item.when }
    assert_redirected_to lost_item_path(assigns(:lost_item))
  end

  test "should destroy lost_item" do
    assert_difference('LostItem.count', -1) do
      delete :destroy, id: @lost_item
    end

    assert_redirected_to lost_items_path
  end
end
