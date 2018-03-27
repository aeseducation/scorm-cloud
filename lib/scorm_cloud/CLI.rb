module ScormCloud
  class CLI
    def self.start
      command = ARGV.shift
      appid = ENV['SCORM-CLOUD-APPID'] || ENV['SCORM_CLOUD_APPID']
      secret = ENV['SCORM-CLOUD-SECRET'] || ENV['SCORM_CLOUD_SECRET']
      api_url = ENV['SCORM-CLOUD-API-URL'] || ENV['SCORM_CLOUD_API_URL']
      opts = {}
      while ARGV.length > 0
        case ARGV[0]
          when '--appid'
            ARGV.shift; appid = ARGV.shift
          when '--secret'
            ARGV.shift; secret = ARGV.shift
          when '--api-url'
            ARGV.shift; api_url = ARGV.shift
          else
            name = ARGV.shift[2..-1].to_sym
            value = ARGV.shift
            opts[name] = value
          end
        end
        sc = ScormCloud.new(appid, secret, api_url)
        puts sc.call(command, opts)
    end
  end
end
