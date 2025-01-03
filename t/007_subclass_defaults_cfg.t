# -*- perl -*-

use strict;
use warnings;
use Data::Dumper qw{Dumper};
use Test::More tests => 18;

{
  package #hide from CPAN
    SMS::Send::My::ClassWithOverrides;
  use base qw{SMS::Send::Driver::WebService};
  sub _username_default {"user_class"};
  sub _password_default {"pass_class"};
  sub _host_default {"host_class"};
  sub _protocol_default {"protocol_class"};
  sub _port_default {"port_class"};
  sub _script_name_default {"script_name_class"};
  sub _warnings_default {"warnings_class"};
  sub _debug_default {"debug_class"};
}

my $service = SMS::Send::My::ClassWithOverrides->new;

isa_ok ($service, 'SMS::Send::My::ClassWithOverrides');
isa_ok ($service, 'SMS::Send::Driver::WebService');
isa_ok ($service, 'SMS::Send::Driver');
isa_ok ($service->cfg, 'Config::IniFiles');
is($service->cfg_section, "My::ClassWithOverrides", "cfg_section");
like($service->cfg_file, qr{\A(\.[/\\])?SMS-Send\.ini\Z}, "cfg_file");
isa_ok($service->cfg_path, "ARRAY");
is($service->cfg_path->[0], ".", "cfg_path[0]");

if ($^O eq 'MSWin32') {
  SKIP :{
    eval('use Win32');
    skip "Win32 not available", 1 if $@;
    is($service->cfg_path->[1], eval('Win32::GetFolderPath(Win32::CSIDL_WINDOWS)'), "cfg_path[1]");
  }
} else {
  SKIP: {
    eval('use Sys::Path');
    skip "Sys::Path not available", 1 if $@;
    is($service->cfg_path->[1], eval('Sys::Path->sysconfdir'), "cfg_path[1]");
  }
}

is($service->username,    'user_class_cfg',        'username');
is($service->password,    'pass_class_cfg',        'password');
is($service->host,        'host_class_cfg',        'host');
is($service->protocol,    'protocol_class_cfg',    'protocol');
is($service->port,        'port_class_cfg',        'port');
is($service->script_name, 'script_name_class_cfg', 'script_name');
is($service->script_name, 'script_name_class_cfg', 'script_name');
is($service->warnings,    'warnings_class_cfg',    'warnings');
is($service->debug,       'debug_class_cfg',       'debug');