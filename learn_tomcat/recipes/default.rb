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
ark 'tomcat_serwar' do
   url node['tomcat']['tomcat_package']
   home_dir node['tomcat']['tomcat_home']
   owner node['tomcat']['user_name']
   group node['tomcat']['group_name']
   action :put
end

#Tomcat server configuration
template "#{node['tomcat']['tomcat_home']}/conf/server.xml" do
   source 'server.conf.erb'
   mode '0644'
   owner node['tomcat']['user_name']
   group node['tomcat']['group_name']
end

#Tomcat catalina configuration
template "#{node['tomcat']['tomcat_home']}/bin/setenv.sh" do
   source 'setenv.sh.erb'
   mode '0755'
   owner node['tomcat']['user_name']
   group node['tomcat']['group_name']
end

#copy sample.war file from source to remote location
remote_file "#{node['tomcat']['tomcat_home']}/webapps/sample.war" do
   owner node['tomcat']['user_name']
   mode '0644'
   source node['tomcat']['source_file']
end


#start and enable the helloworld tomcat service 
service 'tomcat_serwar' do
  action [:enable, :start]
  owner node['tomcat']['user_name']
  group node['tomcat']['group_name']
  subscribes :restart, "template[#{node['tomcat']['catalina_file']}]", :delayed
  subscribes :restart, "template[#{node['tomcat']['server_file']}]", :delayed

end


