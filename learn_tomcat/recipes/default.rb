#Cookbook Name :: learn_tomcat
#Recipe:: default
#Create a group name cool_group
include_recipe 'java'
group node['tomcat']['group_name']

#Create a user name cool_user
user node['tomcat']['user_name'] do
   group node['tomcat']['group_name']
   system 'true'
   shell '/bin/bash'
end

#Install Tomcat 8.0.47 to the default location
learn_tomcat_install 'helloworld' do
   action :install
end

#restart tomcat if there is change in server.xml file
cookbook_file node['tomcat']['server_file'] do
    notifies :restart, 'learn_tomcat_run[helloworld]'
end


#copy sample.war file from source to remote location
remote_file node['tomcat']['remote_file'] do
   owner node['tomcat']['user_name']
   mode '0644'
   source node['tomcat']['source_file']
end


#start and enable the helloworld tomcat service 
learn_tomcat_run 'helloworld' do
  action [:start, :enable]
end


