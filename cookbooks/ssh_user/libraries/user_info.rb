# frozen_string_literal: true

require 'etc'

class Chef
  class Recipe
    def ssh_user_each(&block)
      node['ssh_user']&.[]('users')&.each do |username|
        user_info =
          begin
            Etc.getpwnam(username)
          rescue ArgumentError => e
            log 'etc/passwd error' do 
              message "Could not get /etc/passwd entry for user '#{username}': #{e}"
              level   :error
            end

            next
          end

        block.call(username, user_info)
      end
    end
  end
end
