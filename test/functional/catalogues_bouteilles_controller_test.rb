require 'test_helper'

class CataloguesBouteillesControllerTest < ActionController::TestCase
  setup do
    @catalogues_bouteille = catalogues_bouteilles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:catalogues_bouteilles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create catalogues_bouteille" do
    assert_difference('CataloguesBouteille.count') do
      post :create, catalogues_bouteille: {  }
    end

    assert_redirected_to catalogues_bouteille_path(assigns(:catalogues_bouteille))
  end

  test "should show catalogues_bouteille" do
    get :show, id: @catalogues_bouteille
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @catalogues_bouteille
    assert_response :success
  end

  test "should update catalogues_bouteille" do
    put :update, id: @catalogues_bouteille, catalogues_bouteille: {  }
    assert_redirected_to catalogues_bouteille_path(assigns(:catalogues_bouteille))
  end

  test "should destroy catalogues_bouteille" do
    assert_difference('CataloguesBouteille.count', -1) do
      delete :destroy, id: @catalogues_bouteille
    end

    assert_redirected_to catalogues_bouteilles_path
  end
end
