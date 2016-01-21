module Tweeter
    class UploadController < BaseController
        def get_upload(req)
            render :upload
        end
        
        def post_upload(req)
            uploaded_file = req.params['upload_file']
            FileService.transfer(uploaded_file[:tempfile], uploaded_file[:filename])
            redirect '/upload'
        end
    end
end