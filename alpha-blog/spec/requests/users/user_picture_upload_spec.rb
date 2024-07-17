require 'rails_helper'

RSpec.describe 'UserPictureUploads', type: :request do
  describe 'GET /upload_pic_get' do
    subject(:get_upload_pic) { get upload_pic_path }

    context 'with user connected' do
      let(:user) { create(:user) }
      before { sign_in user }

      it 'allows user to access upload picture page' do
        get_upload_pic
        expect(response).to have_http_status(200)
      end
    end

    context 'with user not connected' do
      it 'does not show the upload picture option' do
        get_upload_pic
        expect(response.body).not_to include('Upload picture')
      end
    end
  end

  describe 'POST /upload_pic_post' do
    subject(:post_upload_pic) { post upload_pic_path, params: { photo: { image: } } }

    context 'with user connected' do
      let(:user) { create(:user) }
      let(:image) { fixture_file_upload('spec/fixtures/files/test.png', 'image/png') }

      before { sign_in user }

      it 'allows user to upload picture' do
        pending('Demander à Tim')
        post_upload_pic
        expect(response).to redirect_to(user_path(user))
        follow_redirect!
        expect(response.body).to include('Profile picture was successfully uploaded')
      end
    end
  end
end
