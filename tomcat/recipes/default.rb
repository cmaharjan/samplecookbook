#Cookbook Name :: tomcat
#Recipe:: default
#Create a group name cool_group
group node['tomcat']['group_name']

#Create a user name cool_user
user node['tomcat']['user_name'] do
   group node['tomcat']['group_name']
   system 'true'
   shell '/bin/bash'
end

#Install Tomcat 8.0.47 to the default location
tomcat_install 'helloworld' do
   tarball_uri node['tomcat']['tomcat_package']
   tomcat_user node['tomcat']['user_name']
   tomcat_group node['tomcat']['group_name']
end

#start and enable the helloworld tomcat service 

tomcat_service 'helloworld' do
  action [:start, :enable]
  tomcat_user node['tomcat']['user_name']
  tomcat_group node['tomcat']['group_name']
end

remote_file node['tomcat']['remote_file'] do
   owner node['tomcat']['user_name']
   mode '0644'
   source node['tomcat']['source_file']
end
