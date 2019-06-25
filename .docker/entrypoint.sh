jsEnvCode=$(env | grep VUE_APP_ | awk -F "=" '{print "window."$1"=\""$2"\";"}')
echo "prepared to save env to /usr/share/nginx/html/env.js"
echo $jsEnvCode
echo $jsEnvCode >/usr/share/nginx/html/env.js
nginx -g 'daemon off;'
