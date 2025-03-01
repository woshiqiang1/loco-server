FROM node:14-alpine as base

# Check https://github.com/nodejs/docker-node/tree/b4117f9333da4138b03a546ec926ef50a31506c3#nodealpine to understand why libc6-compat might be needed.
RUN apk add --no-cache libc6-compat

WORKDIR /app

COPY package*.json ./

RUN npm i

COPY . .

FROM base as production

RUN npm run build

EXPOSE 5001

CMD ["npm", "run", "start:node"]