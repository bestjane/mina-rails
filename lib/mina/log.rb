###########################################################################
# nginx Tasks
###########################################################################

namespace :log do
  desc "view different logs"
  %w(unicorn unicorn-error production).each do |action|
    task  do
      tail_log "#{action}.log"
    end
  end

  task :nginx_access do
    tail_log "nginx/access.log"
  end

  task :nginx_error do
    tail_log "nginx/error.log"
  end
end

task :logs do
  tail_log "#{rails_env}.log"
end


def tail_log (file)
  queue echo_cmd "tail -f #{deploy_to}/#{shared_path}/log/#{file}"
end
