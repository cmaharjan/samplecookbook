#Cookbook Name :: learn_tomcat
#Recipe:: default

include_recipe 'java'

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
   user node['tomcat']['user_name']
   group node['tomcat']['group_name']
end

#Tomcat server configuration
template node['tomcat']['server_file'] do
   source 'server.conf.erb'
   mode '0644'
   owner node['tomcat']['user_name']
   group node['tomcat']['group_name']

#Tomcat catalina configuration
template node['tomcat']['catalina_file'] do
   source 'setenv.sh.erb'
   mode '0755'
   owner node['tomcat']['user_name']
   group node['tomcat']['group_name']

#copy sample.war file from source to remote location
remote_file node['tomcat']['remote_file'] do
   owner node['tomcat']['user_name']
   mode '0644'
   source node['tomcat']['source_file']
end


#start and enable the helloworld tomcat service 
service 'helloworld' do
  action [:enable, :start]
  user node['tomcat']['user_name']
  group node['tomcat']['group_name']
  subscribes :restart, "template[#{node['tomcat']['catalina_file']}]", :delayed
  subscribes :restart, "template[#{node['tomcat']['server_file']}]", :delayed

end


