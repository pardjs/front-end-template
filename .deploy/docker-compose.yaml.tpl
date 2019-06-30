version: '2'
services:
  template:
    container_name: front-end-template
    image: registry.cn-shanghai.aliyuncs.com/pardjs/front-end-template:${appVersion}
    ports:
      - "${servicePort}:80"
    volumes:
      - "./logs:/var/log/nginx/log.log"
    env_file:
      - .env
