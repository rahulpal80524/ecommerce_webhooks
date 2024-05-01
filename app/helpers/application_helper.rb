module ApplicationHelper
    def notify_third_parties(model, message)
      case model
      when 'Product', 'Order', 'Customer'
        send_notification(message)
      else
        raise ArgumentError, "Invalid model name: #{model}"
      end
    end
  
    private
  
    def send_notification(message)
      THIRD_PARTY_ENDPOINTS.each do |endpoint|
        begin
          signature = generate_signature(message)
          
          response = HTTParty.post(endpoint, body: { message: message, signature: signature }.to_json, headers: { 'Content-Type' => 'application/json' })
          unless response.success?
            Rails.logger.error("Failed to notify #{endpoint}: #{response.code} - #{response.message}")
            # Handle failed notification, maybe retry or log the error
          end
        rescue SocketError => e
          Rails.logger.error("Failed to connect to #{endpoint}: #{e.message}")
          # Handle connection errors
        end
      end
    end
  
    def generate_signature(message)
      secret_key = ENV['WEBHOOK_SECRET'] # Retrieve the secret key from environment variables
      return unless secret_key # Return early if secret key is nil
      
      digest = OpenSSL::Digest.new('sha256')
      signature = OpenSSL::HMAC.hexdigest(digest, secret_key, message)
      Base64.encode64(signature).strip # Encode to base64 and remove whitespace
    end

end
