FROM nginx

COPY ./key /etc/nginx/ssl/
COPY . /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]