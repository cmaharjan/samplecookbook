#
# Cookbook Name:: learn_chef_httpd
# Recipe:: default
#
package 'httpd'

service 'httpd' do
  action [:enable, :start]
end
group node['httpd']['group']

user node['httpd']['user'] do
   group node['httpd']['group']
   system true
   shell '/bin/bash'
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
