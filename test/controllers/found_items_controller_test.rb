require 'test_helper'

class FoundItemsControllerTest < ActionController::TestCase
  setup do
    @found_item = found_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:found_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create found_item" do
    assert_difference('FoundItem.count') do
      post :create, found_item: { belongs_to: @found_item.belongs_to, description: @found_item.description, location: @found_item.location, returned: @found_item.returned, when: @found_item.when }
    end

    assert_redirected_to found_item_path(assigns(:found_item))
  end

  test "should show found_item" do
    get :show, id: @found_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @found_item
    assert_response :success
  end

  test "should update found_item" do
    patch :update, id: @found_item, found_item: { belongs_to: @found_item.belongs_to, description: @found_item.description, location: @found_item.location, returned: @found_item.returned, when: @found_item.when }
    assert_redirected_to found_item_path(assigns(:found_item))
  end

  test "should destroy found_item" do
    assert_difference('FoundItem.count', -1) do
      delete :destroy, id: @found_item
    end

    assert_redirected_to found_items_path
  end
end
