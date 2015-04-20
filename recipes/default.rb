package "nginx"

directory node[:nginx][:dir] do
  owner 'root'
  group 'root'
  mode '0755'
end

directory node[:nginx][:log_dir] do
  mode 0755
  owner node[:nginx][:user]
  action :create
end

directory "/data/nginx/cache" do
  mode 0755
  owner node[:nginx][:user]
  action :create
  recursive true
end

%w{sites-available sites-enabled conf.d inc ssl}.each do |dir|
  directory File.join(node[:nginx][:dir], dir) do
    owner 'root'
    group 'root'
    mode '0755'
  end
end

template "nginx.conf" do
  path "#{node[:nginx][:dir]}/nginx.conf"
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

template "#{node[:nginx][:dir]}/sites-available/default" do
  source "default-site.erb"
  owner "root"
  group "root"
  mode 0644
end

template "#{node[:nginx][:dir]}/inc/proxy.conf" do
  source "proxy.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

template "#{node[:nginx][:dir]}/ssl/ssl.crt" do
    cookbook 'nginx'
    mode '0600'
    owner "root"
    group "root"
    source "ssl.key.erb"
    variables :key => node[:nginx][:ssl_crt]
    notifies :restart, "service[nginx]"
end

template "#{node[:nginx][:dir]}/ssl/ssl.key" do
    cookbook 'nginx'
    mode '0600'
    source "ssl.key.erb"
    variables :key => node[:nginx][:ssl_key]
    notifies :restart, "service[nginx]"
end

include_recipe "nginx::service"

service "nginx" do
  action [ :enable, :start ]
end
