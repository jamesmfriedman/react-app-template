##
# NODE APP BUILD
##

FROM node:11-alpine
WORKDIR /app

COPY . .

RUN npm ci

RUN ls -la /app
ENV NODE_ENV=production
RUN npm run build

##
# NGINX SPA BUILD
##
FROM nginx:1.17-alpine

COPY --from=0 /app/build /app

RUN ls -la app
RUN ls -la .

# This tool converts env vars into json to be injected into the config
# Use the CONFIG_VARS environment variable to comma separate a list of environment variables
# to expose to the frontend
ADD config/docker-json-env /usr/local/bin/json_env
RUN chmod +x /usr/local/bin/json_env

# Overwrite default config
COPY config/docker-nginx.template /etc/nginx/conf.d/default.template

# Copy our start script
COPY config/docker-start.sh /

CMD cat /etc/nginx/conf.d/default.template > /etc/nginx/conf.d/default.conf && \
	sed -i -e 's/$PORT/'"$PORT"'/g' /etc/nginx/conf.d/default.conf && \
	# echo 'Nginx Config' && \
	# cat /etc/nginx/conf.d/default.conf && \
	exec nginx -g 'daemon off;'

RUN chmod +x ./docker-start.sh

ENTRYPOINT ["./docker-start.sh"]