FROM node:22-alpine AS base
ENV PNPM_HOME="/pnpm"
ENV PATH="$PNPM_HOME:$PATH"
RUN npm i -g corepack@latest
RUN corepack enable
RUN apk --no-cache add postgresql16-client
RUN adduser --disabled-password --gecos '' haf_admin
RUN adduser --disabled-password --gecos '' myhaf_owner
COPY . /app
COPY ./scripts /app/scripts
WORKDIR /app
RUN chown -R myhaf_owner:myhaf_owner /app

FROM base AS prod-deps
USER myhaf_owner
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --prod --frozen-lockfile

FROM base AS build
USER myhaf_owner
RUN --mount=type=cache,id=pnpm,target=/pnpm/store pnpm install --frozen-lockfile
RUN pnpm run compile

FROM base

USER myhaf_owner
COPY --from=prod-deps /app/node_modules /app/node_modules
COPY --from=build /app/dist /app/dist
COPY --from=build /app/scripts /app/scripts

RUN chmod +x /app/scripts/*.sh

USER root
ENTRYPOINT ["/app/scripts/docker_entrypoint.sh"]
