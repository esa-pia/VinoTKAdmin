require 'test_helper'

class DomainesControllerTest < ActionController::TestCase
  setup do
    @domaine = domaines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:domaines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create domaine" do
    assert_difference('Domaine.count') do
      post :create, domaine: { libelle: @domaine.libelle }
    end

    assert_redirected_to domaine_path(assigns(:domaine))
  end

  test "should show domaine" do
    get :show, id: @domaine
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @domaine
    assert_response :success
  end

  test "should update domaine" do
    put :update, id: @domaine, domaine: { libelle: @domaine.libelle }
    assert_redirected_to domaine_path(assigns(:domaine))
  end

  test "should destroy domaine" do
    assert_difference('Domaine.count', -1) do
      delete :destroy, id: @domaine
    end

    assert_redirected_to domaines_path
  end
end
