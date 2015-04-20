case node[:platform_family]
when "debian"
  default[:nginx][:dir]        = "/etc/nginx"
  default[:nginx][:log_dir]    = "/var/log/nginx"
  default[:nginx][:user]       = "www-data"
  default[:nginx][:binary]     = "/usr/sbin/nginx"
  if node[:platform_version] == "14.04"
    default[:nginx][:pid_file] = "/run/nginx.pid"
  else
    default[:nginx][:pid_file] = "/var/run/nginx.pid"
  end
when "rhel"
  default[:nginx][:dir]        = "/etc/nginx"
  default[:nginx][:log_dir]    = "/var/log/nginx"
  default[:nginx][:user]       = "nginx"
  default[:nginx][:binary]     = "/usr/sbin/nginx"
  default[:nginx][:pid_file]   = "/var/run/nginx.pid"
else
  Chef::Log.error "Cannot configure nginx, platform unknown"
end

default[:nginx][:log_format] = {}

# increase if you accept large uploads
default[:nginx][:client_max_body_size] = "4m"

default[:nginx][:gzip] = "off"
default[:nginx][:gzip_static] = "on"
default[:nginx][:gzip_vary] = "on"
default[:nginx][:gzip_disable] = "MSIE [1-6].(?!.*SV1)"
default[:nginx][:gzip_http_version] = "1.0"
default[:nginx][:gzip_comp_level] = "2"
default[:nginx][:gzip_proxied] = "any"
default[:nginx][:gzip_types] = ["application/x-javascript",
                                "application/xhtml+xml",
                                "application/xml",
                                "application/xml+rss",
                                "text/css",
                                "text/javascript",
                                "text/plain",
                                "text/xml"]
# NGinx will compress "text/html" by default

default[:nginx][:keepalive] = "off"
default[:nginx][:keepalive_timeout] = 65

default[:nginx][:worker_processes] = 10
default[:nginx][:worker_connections] = 1024
default[:nginx][:server_names_hash_bucket_size] = 64

default[:nginx][:proxy_read_timeout] = 60
default[:nginx][:proxy_send_timeout] = 60

default[:nginx][:ssl_key] = <<-EOH
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAzVHUm5jLHqJDgUCQlMabMoxcg1gjAOd5tphEcyo3LlCozcah
Ks+A3Ca0k78oGfJpNRVVIabT7sNXAAb3fUltLykhicC4B7kKnd3+YeJN3Mdy81Na
+jmBJZy5fSB7fCeXZD2gQvx6gLW4uHU/SUzW4iItsLfFRCpImmAvI41EFGozAroJ
i0UoJkwCnpCcfKAS2au2Dka/3QoBqwqW6NtDIfE89ZdigHjigJ/DqNEgWf55UM7O
SE9FsSmt2PUfP3LBQavA0hqX/YrAetAZoEXjTcEVTB/Zhrzta4P/mEpSMibzJq0c
CZisYmovf4E116HpecHuQ+NW2hE5aWa9wSoa0QIDAQABAoIBAAZyjWSddbNukQQc
DO4/FlyN/9G4ENFUc4QCYBPlvXnc2pArrp/ziC5hoMYK+K1n6VnbY6L85CbZR4Ae
t+LdTWpvtjfnL2A+tVCjyfs06hEGyltNwMuexqlxtHlzba1GaQCi1seDui0Uh8pz
FBuvKAhN3nVwL+emFEWUw6YwJ3UkmiK90Qnqpb2I+ZUj1/1zTPMFjMMpAEMLlg/a
wlL+XJzGzTvI8NfNYH/oaxL4BNH+WO1CWRmgbZNbmV95NIeIysuL15XJIMbVBAlf
0pLJri7+iRAOnDr+BKsarOUGBM17W/5x2ASrOt/m8GqaQtHN8TGQKU29Va5FdGl3
wFdySGECgYEA/BTqt3fHuaGfRCFT6RvIX0islr2nJ9kPiGTahLc3JOvpjsZunzxH
mZw7QwIvokM2Z0Jg/umpdkHY2G9wc50RFFu7x2/9dX+EVn3W4izHiwkW7gUUIaWV
PUhthivIX2BNdGU+mlrLB8/QEMIXyqbBQJ3XR8dzPI3HCYXb+u+u1X0CgYEA0ILW
kA6NpTpyo1t5Q4NDYC7pwO/gGeAsF9HnJ57FwMZl+AAd/KSxns/gxeOyL/gJI0WA
LOqGEKSokF2BL+Vjn+tU1xjh2pkrIEyaL+li24r7QBUUo4dQCJCiimDzKtvH5Yc8
cXKw1y8ccaRy8caNMUFAn0icdWcEcTRgfcF7SuUCgYEA7UvPbCgwdjmD0MHC2LST
mcay2S/s86Dsc0vlPHuwSGxfr0xyhCldiWe9jaW4K3oz815UKoLRSIZR1+SHqf3Y
Px7flK2CniIM9NJ+/uiCawqCcEuNmOLjqw3MNDpw4/+mygQou2rupwrkZXIgrV7u
mqI7LtG9U+puzDMbUoxgO40CgYEAuMEWCXM7wwn1BhZJbq7ihllLOm/R7Fub9kdB
QPQIWXXyaDsCVxg/Ym7jxbSp8KMgxaYRmrr7q8earMCNdbkV+190P1uG1EEf23DE
tmtf8xRE6FVFglila9FslJyvGmy/xPt9bTCozSKrW27RgrXh6aDd98VJDSYI4537
WbKU4pkCgYBVe4Ckihn+uqHFztelA6f+e9XWM+8JWhxn01fO0QWPo/yCL8b7pHUk
+M66n3sbn4zQicbtXa+KSU+I2a49qu8zVj1XHFYscZevoweGEZ3QiNZf4w0V9NIu
MExycOooZFqxFYNPgxk5p1gwxlZjpZWrYZHpuccg02sxcUdW1t3UZw==
-----END RSA PRIVATE KEY-----
EOH

default[:nginx][:ssl_crt] = <<-EOH
-----BEGIN CERTIFICATE-----
MIIEgzCCA2ugAwIBAgIJAMK6HyCIslw4MA0GCSqGSIb3DQEBBQUAMIGHMQswCQYD
VQQGEwJVUzEWMBQGA1UECBMNTmV3IEhhbXBzaGlyZTEQMA4GA1UEBxMHTWFkaXNv
bjEZMBcGA1UEChMQRGF2aWQgTWFwbGUgTExDLjEbMBkGA1UECxMSV2ViIEFkbWlu
aXN0cmF0aW9uMRYwFAYDVQQDEw1kYXZlbWFwbGUuY29tMB4XDTE1MDMzMDE2MTAx
NloXDTI1MDMyNzE2MTAxNlowgYcxCzAJBgNVBAYTAlVTMRYwFAYDVQQIEw1OZXcg
SGFtcHNoaXJlMRAwDgYDVQQHEwdNYWRpc29uMRkwFwYDVQQKExBEYXZpZCBNYXBs
ZSBMTEMuMRswGQYDVQQLExJXZWIgQWRtaW5pc3RyYXRpb24xFjAUBgNVBAMTDWRh
dmVtYXBsZS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDNUdSb
mMseokOBQJCUxpsyjFyDWCMA53m2mERzKjcuUKjNxqEqz4DcJrSTvygZ8mk1FVUh
ptPuw1cABvd9SW0vKSGJwLgHuQqd3f5h4k3cx3LzU1r6OYElnLl9IHt8J5dkPaBC
/HqAtbi4dT9JTNbiIi2wt8VEKkiaYC8jjUQUajMCugmLRSgmTAKekJx8oBLZq7YO
Rr/dCgGrCpbo20Mh8Tz1l2KAeOKAn8Oo0SBZ/nlQzs5IT0WxKa3Y9R8/csFBq8DS
Gpf9isB60BmgReNNwRVMH9mGvO1rg/+YSlIyJvMmrRwJmKxiai9/gTXXoel5we5D
41baETlpZr3BKhrRAgMBAAGjge8wgewwHQYDVR0OBBYEFHfmJ0s9/+PoN7aTIVYX
8qbF7hzKMIG8BgNVHSMEgbQwgbGAFHfmJ0s9/+PoN7aTIVYX8qbF7hzKoYGNpIGK
MIGHMQswCQYDVQQGEwJVUzEWMBQGA1UECBMNTmV3IEhhbXBzaGlyZTEQMA4GA1UE
BxMHTWFkaXNvbjEZMBcGA1UEChMQRGF2aWQgTWFwbGUgTExDLjEbMBkGA1UECxMS
V2ViIEFkbWluaXN0cmF0aW9uMRYwFAYDVQQDEw1kYXZlbWFwbGUuY29tggkAwrof
IIiyXDgwDAYDVR0TBAUwAwEB/zANBgkqhkiG9w0BAQUFAAOCAQEAoXOAtF1s0n6M
+24+CdrC2/IUbRjriy3fkR0k4wHjyWBezj18ywQ98NDIxo/oviTD36jXWjyUznuX
Vh9bhk06aLyMpK0SfVoqAf2HPLRIpoXzhA2FecxaIG5Dnd/szUTGFToW9gtftORf
OLoeTM2ell9KKrYIsAmFyleDs/t0Zd3cTiYS3n7g86DJt8mHbabZVpY8xfFylVJs
W3fSbBcIdwRKQlly/l95ZD3sCFuQVjs3s0dzi9p4EvKjb0UFD4oI47qwEy2zGdH6
VwMa+MVe72CrWpSr/rFALKTd8KQSF3Ez+IN0bZmv5nhM2EGCIBStQqNBpJBGUsFs
eE2AGjKlYQ==
-----END CERTIFICATE-----
EOH
