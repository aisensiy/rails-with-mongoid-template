require 'rspec/core/formatters/base_formatter'
require 'json'
require 'rest_client'

class CustomFormatter < RSpec::Core::Formatters::BaseFormatter
  # This registers the notifications this formatter supports, and tells
  # us that this was written against the RSpec 3.x formatter API.
  RSpec::Core::Formatters.register self, :dump_summary

  def dump_summary(notification)
    if notification.failure_count == 0
      print 'verify passed!'
    else
      print 'verify failed!'
    end
    notify(notification.failure_count == 0)
  end

  private

  def directory_name
    File.basename File.expand_path '.'
  end

  def notify(is_success)
    if File.file?('../manifest.json')
      print 'login...'
      meta = JSON.parse(File.read('../manifest.json'))
      response = RestClient.post("#{meta['entry_point']}/authentication", { user_name: 'admin', user_password: '123' }.to_json, {:content_type => :json})
      cookie = response.headers[:set_cookie]

      print 'post result...'
      RestClient.put meta['evaluation_uri'], { status: is_success && "PASSED" || "FAILED", time: Time.now.to_i - meta['first_commit'] / 1000 }.to_json, {:content_type => :json, :cookie => cookie[0]}
    end
  end
end
