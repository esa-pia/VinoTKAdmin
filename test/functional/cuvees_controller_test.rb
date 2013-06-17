require 'test_helper'

class CuveesControllerTest < ActionController::TestCase
  setup do
    @cuvee = cuvees(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cuvees)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cuvee" do
    assert_difference('Cuvee.count') do
      post :create, cuvee: { libelle: @cuvee.libelle }
    end

    assert_redirected_to cuvee_path(assigns(:cuvee))
  end

  test "should show cuvee" do
    get :show, id: @cuvee
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cuvee
    assert_response :success
  end

  test "should update cuvee" do
    put :update, id: @cuvee, cuvee: { libelle: @cuvee.libelle }
    assert_redirected_to cuvee_path(assigns(:cuvee))
  end

  test "should destroy cuvee" do
    assert_difference('Cuvee.count', -1) do
      delete :destroy, id: @cuvee
    end

    assert_redirected_to cuvees_path
  end
end
