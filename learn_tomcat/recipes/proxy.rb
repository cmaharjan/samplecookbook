#
# Cookbook Name:: learn_tomcat
# Recipe:: proxy
#
# Creating a group
group node['httpd']['group']

#Creating a user
user node['httpd']['user'] do
   group node['httpd']['group']
   system true
   shell '/bin/bash'
end

# Installing apache package
package 'httpd'

# Enabling and starting apache package
service 'httpd' do
  action [:enable, :start]
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
  mode '0644'
  owner node['httpd']['user']
  group node['httpd']['group']
end

template '/etc/httpd/conf/httpd.conf' do
  source 'httpd.conf.erb'
  mode '0644'
  owner node['httpd']['user']
  group node['httpd']['group']
end
