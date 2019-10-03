# Node v10.16.3 as base image
FROM node:10.16.3

# Create new user for container instead of using root
RUN useradd --user-group --create-home --shell /bin/false dev && apt-get clean

# Set env variable
ENV HOME=/home/dev

# Copy source code
COPY package.json $HOME/app/
COPY src/ $HOME/app/src

# Set permission for user dev
RUN chown -R dev:dev $HOME/* /usr/local/

# Specify working dir
WORKDIR $HOME/app

# Run command to install packages
USER dev
RUN npm install --production

USER root
# Set permisson for user dev
RUN chown -R dev:dev $HOME/*

USER dev
EXPOSE 3000
CMD ["npm", "start"]