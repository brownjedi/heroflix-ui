FROM node:8.6.0

# File Author / Maintainer
LABEL maintainer="Sai Karthik Reddy Ginni"

# Override the base log level (info).
ENV NPM_CONFIG_LOGLEVEL warn

# Set port
ENV PORT 4200
EXPOSE 4200

# Install and configure `serve`.
RUN yarn global add serve --prefix /usr/local

# Create app directory
RUN mkdir -p /usr/app
WORKDIR /usr/app

# Install all dependencies of the current project.
COPY package.json .
COPY yarn.lock .
RUN yarn install --silent

# Copy all local files into the image.
COPY . .

# build the prod
RUN yarn build --prod

# serve
CMD ["serve", "-s", "dist"]
