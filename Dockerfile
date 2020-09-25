FROM node:12 as builder
COPY . /usr/src/app
WORKDIR /usr/src/app
RUN yarn && yarn test && yarn compile && yarn --production


FROM node:12 as runner
COPY --from=builder /usr/src/app/node_modules /usr/src/app/node_modules
COPY --from=builder /usr/src/app/dist /usr/src/app/dist
EXPOSE 8080
WORKDIR /usr/src/app
CMD ["node", "dist"]