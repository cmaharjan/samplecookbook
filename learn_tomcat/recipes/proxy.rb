#
# Cookbook Name:: learn_tomcat
# Recipe:: proxy
#
# Creating a group
group node['web']['group']

# Creating a user
user node['web']['user'] do
  group node['web']['group']
  system true
  shell '/bin/bash'
end

if node['webserver'] == 'apache'
  # Installing apache package
  package 'httpd'

  template '/var/www/html/index.html' do
    source 'index.html.erb'
    mode '0644'
    owner node['web']['user']
    group node['web']['group']
  end

  template '/etc/httpd/conf/httpd.conf' do
    source 'httpd.conf.erb'
    mode '0644'
    owner node['web']['user']
    group node['web']['group']
  end

  # Enabling and starting apache package
  service 'httpd' do
    action [:enable, :start]
  end

elsif node['webserver'] == 'nginx'
  # include_recipe 'nginx'
  package 'nginx'

  template '/etc/nginx/nginx.conf' do
    source 'nginx.conf.erb'
    mode '0644'
    owner node['web']['user']
    group node['web']['group']
    notifies :reload, 'service[nginx]', :delayed
  end

  service 'nginx' do
    supports :status => true, :restart => true, :reload => true
    action :enable
  end

else
  'unexpected proxy provider'
end
