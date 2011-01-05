require 'test_helper'

class SurveychoicesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:surveychoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create surveychoice" do
    assert_difference('Surveychoice.count') do
      post :create, :surveychoice => { }
    end

    assert_redirected_to surveychoice_path(assigns(:surveychoice))
  end

  test "should show surveychoice" do
    get :show, :id => surveychoices(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => surveychoices(:one).to_param
    assert_response :success
  end

  test "should update surveychoice" do
    put :update, :id => surveychoices(:one).to_param, :surveychoice => { }
    assert_redirected_to surveychoice_path(assigns(:surveychoice))
  end

  test "should destroy surveychoice" do
    assert_difference('Surveychoice.count', -1) do
      delete :destroy, :id => surveychoices(:one).to_param
    end

    assert_redirected_to surveychoices_path
  end
end
