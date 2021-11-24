FROM nginx:1.19-alpine

COPY nginx.conf.template /etc/nginx/
COPY entrypoint.sh entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
