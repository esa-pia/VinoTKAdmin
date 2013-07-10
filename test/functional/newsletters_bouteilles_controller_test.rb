require 'test_helper'

class NewslettersBouteillesControllerTest < ActionController::TestCase
  setup do
    @newsletters_bouteille = newsletters_bouteilles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:newsletters_bouteilles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create newsletters_bouteille" do
    assert_difference('NewslettersBouteille.count') do
      post :create, newsletters_bouteille: { rabais: @newsletters_bouteille.rabais }
    end

    assert_redirected_to newsletters_bouteille_path(assigns(:newsletters_bouteille))
  end

  test "should show newsletters_bouteille" do
    get :show, id: @newsletters_bouteille
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @newsletters_bouteille
    assert_response :success
  end

  test "should update newsletters_bouteille" do
    put :update, id: @newsletters_bouteille, newsletters_bouteille: { rabais: @newsletters_bouteille.rabais }
    assert_redirected_to newsletters_bouteille_path(assigns(:newsletters_bouteille))
  end

  test "should destroy newsletters_bouteille" do
    assert_difference('NewslettersBouteille.count', -1) do
      delete :destroy, id: @newsletters_bouteille
    end

    assert_redirected_to newsletters_bouteilles_path
  end
end
