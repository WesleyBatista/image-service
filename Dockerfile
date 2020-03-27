FROM python:3.7-slim-buster AS build-env

WORKDIR /app/

COPY ImageService_pb2_grpc.py ./

COPY ImageService_pb2.py ./

COPY requirements.txt ./

RUN pip install -r requirements.txt

COPY *.py ./

FROM gcr.io/distroless/python3-debian10
COPY --from=build-env /app /app
COPY --from=build-env /usr/local/lib/python3.7/site-packages /usr/local/lib/python3.7/site-packages
WORKDIR /app

ENV PYTHONPATH=/usr/local/lib/python3.7/site-packages
