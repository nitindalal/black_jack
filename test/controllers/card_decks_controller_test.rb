require 'test_helper'

class CardDecksControllerTest < ActionController::TestCase
  setup do
    @card_deck = card_decks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:card_decks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create card_deck" do
    assert_difference('CardDeck.count') do
      post :create, card_deck: {  }
    end

    assert_redirected_to card_deck_path(assigns(:card_deck))
  end

  test "should show card_deck" do
    get :show, id: @card_deck
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @card_deck
    assert_response :success
  end

  test "should update card_deck" do
    patch :update, id: @card_deck, card_deck: {  }
    assert_redirected_to card_deck_path(assigns(:card_deck))
  end

  test "should destroy card_deck" do
    assert_difference('CardDeck.count', -1) do
      delete :destroy, id: @card_deck
    end

    assert_redirected_to card_decks_path
  end
end
