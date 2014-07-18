# Mina Rails
======================================
Environment
---
[Ubuntu Server 12.04](http://releases.ubuntu.com/12.04/)

[git](https://github.com/git/git)

[rvm](https://github.com/wayneeseguin/rvm)

[rails](https://github.com/rails/rails)

[unicorn](http://unicorn.bogomips.org/)

[nginx](http://wiki.nginx.org/Main)

[nodejs](http://nodejs.org/)  precompile assests

```bash
# do not use nvm(https://github.com/creationix/nvm) to install nodejs.
# that counld not be loaded in mina. sorry, I don't know why.
sudo apt-get install nodejs
# is fine.
```

[mina](https://github.com/nadarei/mina)

```ruby
group :development do
  gem 'mina'
end
```

Step up
---
copy this into your rails project.

```bash
cp ./mina... ./YOURPROJECT/
```
edit the server information,
and customize the unicorn script and nginx configure in template folder.
then do
```bash
mina setup
```

Start
---
```bash
# copy config/deploy.rb to $YOUR_APP/config/deploy.rb
# copy lib/mina to $YOUR_APP/lib
# edit common settings and anything you like in config/deploy.rb
# edit lib/mina/servers/*.rb to match your server configuration
mina init
mina setup          # Set up deploy server with paths, configs, etc. Requires sudo privileges or sudoer user
mina deploy
mina nginx:restart  # or nginx:start
mina god:start      # it will also run unicorn automagically
```

```bash
create_extra_paths
god:setup
god:upload
unicorn:upload
nginx:upload
```

Deploy
---
```bash
mina init to=production
mina setup to=production
mina deploy to=production
mina nginx:restart to=production
mina god:start to=production
```
You can, of course, set the :default_server to anything you like.

and if you don't set separate sudoer user, these tasks invoked as well, implying that current user have sudo rights (if he doesn't, you'll be prompted to run 'sudo_setup' task, which does exactly that):

```bash
god:link
unicorn:link
nginx:setup
nginx:link
```

```bash
mina health
```

If you've changed some of the config files for god/unicorn/nginx, you can upload them to server with `mina config:upload`.
If changed code includes unicorn or god control script (service), you will also need to run `mina config:link`, that requires sudo privileges. Keep in mind, that any nginx controlling task also requires sudo! Those are: stop, start, restart, reload, and status.

Rollback
---
mina can change your release very easily.

Others
---
[RBates Railscast](http://railscasts.com/episodes/292-virtual-machines-with-vagrant)


