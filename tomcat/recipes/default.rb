#Cookbook Name :: tomcat
#Recipe:: default
#Create a group name cool_group
group 'cool_group'

#Create a user name cool_user
user 'cool_user' do
   group 'cool_group'
   system 'true'
   shell '/bin/bash'
end

#Install Tomcat 8.0.47 to the default location
tomcat_install 'helloworld' do
   tarball_uri 'http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.47/bin/apache-tomcat-8.0.47.tar.gz'
   tomcat_user 'cool_user'
   tomcat_group 'cool_group'
end

#start and enable the helloworld tomcat service 

tomcat_service 'helloworld' do
  action [:start, :enable]
  tomcat_user 'cool_user'
  tomcat_group 'cool_group'
end

remote_file '/opt/tomcat_helloworld/webapps/sample.war' do
   owner 'cool_user'
   mode '0644'
   source 'https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war'
end
