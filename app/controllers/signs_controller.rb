class SignsController < ApplicationController

  S3_BUCKET_NAME = ENV['AWS_BUCKET']
  S3_ACCESS_KEY = ENV['AWS_ACCESS_KEY_ID']
  S3_SECRET_KEY = ENV['AWS_SECRET_ACCESS_KEY']
  S3_URL = 'http://s3.amazonaws.com/'

  def sign
    objectName = params[:s3_object_name]
    mimeType = params['s3_object_type']
    expires = Time.now.to_i + 100 # PUT request to S3 must start within 100 seconds

    amzHeaders = "x-amz-acl:public-read" # set the public read permission on the uploaded file
    stringToSign = "PUT\n\n#{mimeType}\n#{expires}\n#{amzHeaders}\n/#{S3_BUCKET_NAME}/tracks/#{objectName}";
    sig = CGI::escape(Base64.strict_encode64(OpenSSL::HMAC.digest('sha1', S3_SECRET_KEY, stringToSign)))
    render :json => {
      signed_request: CGI::escape("#{S3_URL}#{S3_BUCKET_NAME}/tracks/#{objectName}?AWSAccessKeyId=#{S3_ACCESS_KEY}&Expires=#{expires}&Signature=#{sig}"),
      url: "http://s3.amazonaws.com/#{S3_BUCKET_NAME}/tracks/#{objectName}"
    }.to_json
  end

end
