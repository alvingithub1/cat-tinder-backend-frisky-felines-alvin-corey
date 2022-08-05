require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it"gets us a list of cats" do
      Cat.create(
        name: 'Homer',
        age: 12,
        enjoys: 'Food mostly, really just food.',
        image: 'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1015&q=80'
      )

      get '/cats'
      cat = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(cat.length).to eq 1
    end
  end

  describe "POST /create" do
    it"creates a cat" do
      cat_params = {
        cat: {
          name: 'Homer',
          age: 12,
          enjoys: 'Food mostly, really just food.',
          image: 'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1015&q=80'
        }
      }

      post '/cats', params: cat_params
      expect(response).to have_http_status(200)
      cat = Cat.first
      expect(cat.name).to eq 'Homer'
      expect(cat.age).to eq 12
      expect(cat.enjoys).to eq 'Food mostly, really just food.'
      expect(cat.image).to eq 'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1015&q=80'
    end
  end

  describe"PATCH /update" do
    it "updates a cat" do
      cat_params = {
        cat: {
          name: 'Homer',
          age: 12,
          enjoys: 'Food mostly, really just food.',
          image: 'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1015&q=80'
        }
      }

      post '/cats', params: cat_params
      cat = Cat.first
      updated_cat_params = {
        cat: {
          name: 'Homer',
          age: 13,
          enjoys: 'Food mostly, really just food.',
          image: 'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1015&q=80'
        }
      }
      patch"/cats/#{cat.id}", params: updated_cat_params
      updated_cat = Cat.find(cat.id)
      expect(response).to have_http_status(200)
      expect(updated_cat.age).to eq 13
    end
  end

  describe"DELETE /destroy" do
    it"deletes a cat" do
      cat_params = {
        cat: {
          name: 'Homer',
          age: 12,
          enjoys: 'Food mostly, really just food.',
          image: 'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1015&q=80'
        }
      }

      post "/cats", params: cat_params
      cat = Cat.first
      delete"/cats/#{cat.id}"
      expect(response).to have_http_status(200)
      cats = Cat.all
      expect(cats).to be_empty
    end
  end

  describe "cannot create a cat without valid attributes" do
    it "doesn't create a cat without a name" do
      cat_params = {
        cat: {
          age: 12,
          enjoys: 'Food mostly, really just food.',
          image: 'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1015&q=80'
        }
      }

      post "/cats", params: cat_params
      expect(response.status).to eq 422
      cat = JSON.parse(response.body)#come back as ruby hash
      expect(cat['name']).to include "can't be blank" # checking if name is blank
    end

    it "doesn't create a cat without an age" do
      cat_params = {
        cat: {
          name: 'frisky',
          enjoys: 'Food mostly, really just food.',
          image: 'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1015&q=80'
        }
      }

      post "/cats", params: cat_params
      expect(response.status).to eq 422
      cat = JSON.parse(response.body)#come back as ruby hash
      expect(cat['age']).to include "can't be blank" # checking if name is blank
    end

    it "doesn't create a cat without what it enjoys" do
      cat_params = {
        cat: {
          name: 'frisky',
          age: 2,
          image: 'https://images.unsplash.com/photo-1573865526739-10659fec78a5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1015&q=80'
        }
      }

      post "/cats", params: cat_params
      expect(response.status).to eq 422
      cat = JSON.parse(response.body)#come back as ruby hash
      expect(cat['enjoys']).to include "can't be blank" # checking if name is blank
    end

    it "doesn't create a cat without an image" do
      cat_params = {
        cat: {
          name: 'frisky',
          age: 2,
          enjoys: 'Food mostly, really just food.',
        }
      }

      post "/cats", params: cat_params
      expect(response.status).to eq 422
      cat = JSON.parse(response.body)#come back as ruby hash
      expect(cat['image']).to include "can't be blank" # checking if name is blank
    end
    
  end
end
