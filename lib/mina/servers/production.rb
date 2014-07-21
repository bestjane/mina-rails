# Ubuntu
namespace :env do
  task :production => [:environment] do
    set :domain,              'example.com'
    set :deploy_to,           '/home/deploy/example'
    set :port,                '22'
    # set :identity_file,       'config/keys/example' # if your ssh is using identity file.
    set :user,                'deploy'
    set :group,               'deploy'
    set :services_path,       '/etc/init.d'          # where your God and Unicorn service control scripts will go
    set :nginx_path,          '/etc/nginx'
    set :deploy_server,       'production'                   # just a handy name of the server
    invoke :defaults                                         # load rest of the config
    invoke :"rvm:use[#{rvm_string}]"                       # since my prod server runs 1.9 as default system ruby, there's no need to run rvm:use
  end
end
