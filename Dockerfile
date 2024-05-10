FROM node:12 as build

RUN mkdir -p /home/angular/front

WORKDIR /home/angular/front

COPY . .

RUN npm install --force

RUN npm run build

FROM nginx:latest
RUN rm -rf /usr/share/nginx/html/* && rm -rf /etc/nginx/nginx.conf
COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /home/angular/front/dist/* /usr/share/nginx/html

EXPOSE 80
