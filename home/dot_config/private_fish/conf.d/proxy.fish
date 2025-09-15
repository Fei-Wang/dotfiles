set -gx http_proxy http://127.0.0.1:7890
set -gx https_proxy http://127.0.0.1:7890
set -gx all_proxy socks5://127.0.0.1:7890
set -gx HTTP_PROXY $http_proxy
set -gx HTTPS_PROXY $https_proxy
set -gx ALL_PROXY $all_proxy
