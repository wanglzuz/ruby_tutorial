require 'spec_helper'
require "rails_helper"

RSpec.describe ArticlesController, :type => :request do
  describe 'Access Token Authentication' do
    context 'when access token is invalid' do
      it 'returns 401' do


        post "/articles.json", params: {"article" => {"title" => "Ahoj", "text" => "ahoj"}}

        expect(response).to have_http_status 401


        expect(Article.count).to eq 0
      end
    end

    context 'when sending a html request' do
      it 'does not require access token' do

        post "/articles", params: {"article" => {"title" => "Ahojda", "text" => "ahoj"}}

        expect(response).to have_http_status 302
        article = assigns(:article)
        expect(response).to redirect_to(article)
        follow_redirect!

        expect(response).to render_template(:show)
        expect(response.body).to include("ahoj")

        expect(Article.count).to eq 1
      end
    end

    context 'when access token is valid for a json request' do
      it 'saves the article' do


        post "/articles.json", params: {"article" => {"title" => "Dobrý den.", "text" => "ahoj"}}, :headers => {"access-token" => 'AHU-69-27'}

        expect(response).to have_http_status 201
        #expect(assigns(:article).text).to eq "ahoj"

      end
    end
  end
end