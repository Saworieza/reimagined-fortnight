# development.rb
set :development, :develop
set :unicorn_rack_env, "development"
set :rails_env, 'development'
set :migration_role, 'db'
 
role :app, %w{ec2-18-216-21-154.us-east-2.compute.amazonaws.com} # Server IP Address
role :web, %w{ec2-18-216-21-154.us-east-2.compute.amazonaws.com}
role :db, %w{ec2-18-216-21-154.us-east-2.compute.amazonaws.com}
 
set :ssh_options, {
keys: [File.expand_path('~/.ssh/production.pem')],
forward_agent: true,
auth_methods: %w(publickey)
}
 
server 'ec2-18-216-21-154.us-east-2.compute.amazonaws.com', user: 'ubuntu', roles: %w{web app db}