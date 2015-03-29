#
# Cookbook Name:: simple-web
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'apt'


httpd_service 'default' do
  action [:create, :start]
end

httpd_config 'simple' do
  source 'simple.erb'
  notifies :restart, 'httpd_service[default]'
end

directory '/var/www/css/' do
  mode '0755'
  action :create
end

cookbook_file 'bootstrap.css' do
  path '/var/www/css/bootstrap.css'
  action :create_if_missing
end

template '/var/www/index.html' do
  source 'index.html.erb'
  variables({
     :message => node["simple-web"]["message"],
  })
end
