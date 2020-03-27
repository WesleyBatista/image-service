.DEFAULT_GOAL := default

generate-requirements-txt:
	poetry export --format requirements.txt > requirements.txt

proto:
	python3 -m grpc_tools.protoc -I . --python_out=. --grpc_python_out=. *.proto

docker-compose:
	docker-compose up --build

default: generate-requirements-txt proto docker-compose
