require 'test_helper'

class MillesimesControllerTest < ActionController::TestCase
  setup do
    @millesime = millesimes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:millesimes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create millesime" do
    assert_difference('Millesime.count') do
      post :create, millesime: { valeur: @millesime.valeur }
    end

    assert_redirected_to millesime_path(assigns(:millesime))
  end

  test "should show millesime" do
    get :show, id: @millesime
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @millesime
    assert_response :success
  end

  test "should update millesime" do
    put :update, id: @millesime, millesime: { valeur: @millesime.valeur }
    assert_redirected_to millesime_path(assigns(:millesime))
  end

  test "should destroy millesime" do
    assert_difference('Millesime.count', -1) do
      delete :destroy, id: @millesime
    end

    assert_redirected_to millesimes_path
  end
end
