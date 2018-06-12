#Cookbook Name :: learn_tomcat
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
learn_tomcat_install 'helloworld' do
   action :install
end

#start and enable the helloworld tomcat service 

learn_tomcat_run 'helloworld' do
  action [:start, :enable]
end


remote_file node['tomcat']['remote_file'] do
   owner node['tomcat']['user_name']
   mode '0644'
   source node['tomcat']['source_file']
end
