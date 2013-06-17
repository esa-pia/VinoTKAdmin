require 'test_helper'

class BouteillesControllerTest < ActionController::TestCase
  setup do
    @bouteille = bouteilles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bouteilles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bouteille" do
    assert_difference('Bouteille.count') do
      post :create, bouteille: { appellation: @bouteille.appellation, description: @bouteille.description, nouveau: @bouteille.nouveau, prix: @bouteille.prix }
    end

    assert_redirected_to bouteille_path(assigns(:bouteille))
  end

  test "should show bouteille" do
    get :show, id: @bouteille
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bouteille
    assert_response :success
  end

  test "should update bouteille" do
    put :update, id: @bouteille, bouteille: { appellation: @bouteille.appellation, description: @bouteille.description, nouveau: @bouteille.nouveau, prix: @bouteille.prix }
    assert_redirected_to bouteille_path(assigns(:bouteille))
  end

  test "should destroy bouteille" do
    assert_difference('Bouteille.count', -1) do
      delete :destroy, id: @bouteille
    end

    assert_redirected_to bouteilles_path
  end
end
