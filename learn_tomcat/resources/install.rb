property :state, String
action :install do
   tarball_uri node['tomcat']['tomcat_package']
   tomcat_user node['tomcat']['user_name']
   tomcat_group node['tomcat']['group_name']
end
