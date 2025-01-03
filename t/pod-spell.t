use Test::More;
eval "use Test::Spelling";
plan skip_all => "Test::Spelling required for testing POD spelling" if $@;
add_stopwords(<DATA>);
all_pod_files_spelling_ok();

__DATA__
API
SMS
TextPower
WebService
ua
url
username
INI
PWD
cfg
filename
http
ini
namespace
Win32
isa
Kannel
SMSBox
stringifies
uat
STDERR
STDOUT
urls
GitHub
