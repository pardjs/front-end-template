FROM node:10 as builder
RUN pwd
WORKDIR /
RUN npm i yarn -g
COPY ./package.json .
COPY ./yarn.lock .
RUN yarn
COPY . .
RUN yarn run build:prod

FROM nginx:latest
COPY --from=builder /dist/ /usr/share/nginx/html
COPY src/graphql/ /usr/share/nginx/html/graphql
COPY ./robots.txt /usr/share/nginx/html
COPY ./.docker/nginx.conf /etc/nginx/conf.d/default.conf
COPY ./.docker/entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh