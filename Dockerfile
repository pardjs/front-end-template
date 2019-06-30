FROM node:10 as builder
RUN pwd
WORKDIR /
RUN npm i yarn -g
COPY ./package.json .
COPY ./yarn.lock .
RUN yarn
COPY . .
RUN yarn run build

FROM nginx:1.16
COPY --from=builder /dist/ /usr/share/nginx/html
COPY ./robots.txt /usr/share/nginx/html
COPY ./.docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY ./.docker/entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh