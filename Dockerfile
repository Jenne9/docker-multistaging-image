FROM python:alpine AS base
WORKDIR /app
RUN pip install mkdocs

FROM base AS init
CMD ["mkdocs", "new", "projet"]

FROM base AS dev
CMD ["mkdocs", "serve", "-a", "0.0.0.0:8000"]

FROM base AS build
COPY mkdocs.yml .
COPY docs docs/
RUN mkdocs build

FROM caddy AS PROD
COPY --from=build /app/site /usr/share/caddy




