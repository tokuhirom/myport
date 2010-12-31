url 'http://nginx.org/download/nginx-0.8.48.tar.gz';

sub install {
    if (-f "/etc/debian_version") {
        run "sudo aptitude -y install libpcre3-dev libssl-dev";
    }
    configure(qw/--with-http_stub_status_module --with-http_dav_module/);
    make;
    make 'install';
}

