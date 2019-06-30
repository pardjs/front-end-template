version: '2'
services:
  template:
    container_name: template
    # put .env file in the project dir
    image: registry.cn-shanghai.aliyuncs.com/pardjs/template:${appVersion}
    volumes:
      - "./logs:/var/log/nginx/log.log"
