require 'test_helper'

class ProduitPharesControllerTest < ActionController::TestCase
  setup do
    @produit_phare = produit_phares(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:produit_phares)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create produit_phare" do
    assert_difference('ProduitPhare.count') do
      post :create, produit_phare: { description: @produit_phare.description, image_content_type: @produit_phare.image_content_type, image_file_name: @produit_phare.image_file_name, image_file_size: @produit_phare.image_file_size, image_updated_at: @produit_phare.image_updated_at, rabais: @produit_phare.rabais }
    end

    assert_redirected_to produit_phare_path(assigns(:produit_phare))
  end

  test "should show produit_phare" do
    get :show, id: @produit_phare
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @produit_phare
    assert_response :success
  end

  test "should update produit_phare" do
    put :update, id: @produit_phare, produit_phare: { description: @produit_phare.description, image_content_type: @produit_phare.image_content_type, image_file_name: @produit_phare.image_file_name, image_file_size: @produit_phare.image_file_size, image_updated_at: @produit_phare.image_updated_at, rabais: @produit_phare.rabais }
    assert_redirected_to produit_phare_path(assigns(:produit_phare))
  end

  test "should destroy produit_phare" do
    assert_difference('ProduitPhare.count', -1) do
      delete :destroy, id: @produit_phare
    end

    assert_redirected_to produit_phares_path
  end
end
