require 'test_helper'

class EvenementsControllerTest < ActionController::TestCase
  setup do
    @evenement = evenements(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:evenements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create evenement" do
    assert_difference('Evenement.count') do
      post :create, evenement: { date_debut: @evenement.date_debut, date_fin: @evenement.date_fin, description: @evenement.description, image_content_type: @evenement.image_content_type, image_file_name: @evenement.image_file_name, image_file_size: @evenement.image_file_size, image_updated_at: @evenement.image_updated_at, titre: @evenement.titre }
    end

    assert_redirected_to evenement_path(assigns(:evenement))
  end

  test "should show evenement" do
    get :show, id: @evenement
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @evenement
    assert_response :success
  end

  test "should update evenement" do
    put :update, id: @evenement, evenement: { date_debut: @evenement.date_debut, date_fin: @evenement.date_fin, description: @evenement.description, image_content_type: @evenement.image_content_type, image_file_name: @evenement.image_file_name, image_file_size: @evenement.image_file_size, image_updated_at: @evenement.image_updated_at, titre: @evenement.titre }
    assert_redirected_to evenement_path(assigns(:evenement))
  end

  test "should destroy evenement" do
    assert_difference('Evenement.count', -1) do
      delete :destroy, id: @evenement
    end

    assert_redirected_to evenements_path
  end
end
