# Cookbook Name :: learn_tomcat
# Recipe:: default

include_recipe 'java'

# Create a group name cool_group
group node['tomcat']['group_name']

# Create a user name cool_user
user node['tomcat']['user_name'] do
  group node['tomcat']['group_name']
  system true
  shell '/bin/bash'
end

# Install Tomcat 8.0.47 to the default location
ark node['tomcat']['tomcat_dirname'] do  #install tomcat in /usr/local/tomcat_serwar
  url node['tomcat']['tomcat_package']
  owner node['tomcat']['user_name']
  group node['tomcat']['group_name']
  action :put
end

# Tomcat server configuration
template "#{node['tomcat']['tomcat_home']}/conf/server.xml" do
  source 'server.conf.erb'
  mode '0644'
  owner node['tomcat']['user_name']
  group node['tomcat']['group_name']
end

# Tomcat catalina configuration
template "#{node['tomcat']['tomcat_home']}/bin/setenv.sh" do
  source 'setenv.sh.erb'
  mode '0755'
  owner node['tomcat']['user_name']
  group node['tomcat']['group_name']
end

# Tomcat init script configuration
#template "/etc/init.d/#{node['tomcat']['tomcat_dirname']}" do
#template "/etc/init.d/tomcat8" do
# source 'init.conf.erb'
#  mode '0755'
#  owner node['tomcat']['user_name']
#  group node['tomcat']['group_name']
#end
template "/usr/lib/systemd/system/tomcat8.service" do
  source 'tomcat8.service.erb'
  mode '0755'
  owner node['tomcat']['user_name']
  group node['tomcat']['group_name']
end


# copy sample.war file from source to remote location
remote_file "#{node['tomcat']['tomcat_home']}/webapps/sample.war" do
  owner node['tomcat']['user_name']
  mode '0644'
  source node['tomcat']['source_file']
end

#create default catalina.pid file to prevent restart error for 1st run of cookbook
file "#{node['tomcat']['tomcat_home']}/catalina.pid" do
  mode '0755'
  owner node['tomcat']['user_name']
  group node['tomcat']['group_name']
  action :create
  not_if { ::File.exist?("#{node['tomcat']['tomcat_home']}/catalina.pid")}
end

# start and enable the helloworld tomcat service
#service node['tomcat']['tomcat_dirname'] do
service "tomcat8.service" do
  supports :restart =>true
  action :enable
#  owner node['tomcat']['user_name']
#  group node['tomcat']['group_name']
  subscribes :restart, "template[#{node['tomcat']['tomcat_home']}/bin/setenv.sh]", :delayed
  subscribes :restart, "template[#{node['tomcat']['tomcat_home']}/conf/server.xml]", :delayed
end

# resource for debug 
breakpoint 'tomact-debug' do
  action :break
end
