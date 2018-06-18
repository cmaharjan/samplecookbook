# installation
default['tomcat']['tomcat_install_path'] = '/usr/local'
default['tomcat']['tomcat_dirname'] = 'tomcat_serwar'
default['tomcat']['tomcat_home'] = "#{node['tomcat']['tomcat_install_path']}/#{node['tomcat']['tomcat_dirname']}"
default['tomcat']['tomcat_package'] = 'http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.47/bin/apache-tomcat-8.0.47.tar.gz'
default['tomcat']['source_file'] = 'https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war'

# O.S related settings
default['tomcat']['group_name'] = 'cool_group'
default['tomcat']['user_name'] = 'cool_user'

# configuration
default['tomcat']['java-opts'] = '-Xmx512m'
default['tomcat']['port'] = '8081'
