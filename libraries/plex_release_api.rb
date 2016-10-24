require 'openssl'
require 'net/http'
require 'net/https'
require 'json'

module Plex
  module ReleaseApi
    DEFAULT_API_URL ||= 'https://plex.tv'.freeze

    class Client
      def initialize(opts = {})
        @api_url = URI(opts[:api_url] || DEFAULT_API_URL)
        @channel = opts[:channel]
        @plex_token = opts[:plex_token]
        validate_opts!
      end

      def pms_releases
        releases(1)
      end

      def pht_releases
        releases(2)
      end

      def pmp_releases
        releases(3)
      end

      def releases(product)
        params = {}
        params['channel'] = @channel if @channel
        res = api_get("/api/downloads/#{product}.json", params)
        process_releases(res)
      end

      private

      def api_get(path, params = {})
        uri = URI.join(@api_url, path)
        uri.query = URI.encode_www_form(params)
        req = Net::HTTP::Get.new(uri)
        req['X-Plex-Token'] = @plex_token if @plex_token
        http = Net::HTTP.new(@api_url.host, @api_url.port)
        http.use_ssl = true if @api_url.scheme == 'https'
        http.request(req)
      end

      def process_releases(res)
        rels = {}
        hsh = JSON.parse(res.body)
        hsh.each do |hardware, oses|
          next unless hardware == 'computer'
          oses.each do |os, meta|
            meta['releases'].each do |rel|
              distro =  case os
                        when 'Windows'
                          'windows'
                        when 'Linux'
                          case rel['label']
                          when /centos/i
                            'rhel'
                          when /fedora/i
                            'fedora'
                          when /ubuntu/i
                            'debian'
                          else
                            rel['distro']
                          end
                        when 'FreeBSD'
                          'freebsd'
                        when 'Mac'
                          'mac_os_x'
                        else
                          next
                        end
              rels[distro] ||= {}
              arch = rel['build'].split('-').last
              rels[distro][arch] = rel['url']
            end
          end
        end
        rels['windows']['x86_64'] = rels['windows']['i386']
        rels
      end

      def validate_opts!
        unless [nil, 'plexpass'].include?(@channel)
          fail ArgumentError, "Invalid channel '#{@channel}'"
        end

        if @channel == 'plexpass' && @plex_token.to_s.empty?
          fail ArgumentError, "'plex_token' must be set when using channel 'plexpass'"
        end
      end
    end
  end
end
