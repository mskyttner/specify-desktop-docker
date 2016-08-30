PWD := $(shell pwd)
NAME := dina/specify-desktop:v6
XSOCK := /tmp/.X11-unix/X0
SRC_DATA :=  http://archive.org/download/dw-collectionsdata/dina_web.sql.gz
SRC_SW := http://update.specifysoftware.org/Specify_unix_64.sh

all: build up

init:
	@echo "Caching downloads locally..."
	@test -f Specify_unix_64.sh || \
		(wget $(SRC_SW) && chmod +x Specify_unix_64.sh)

	@echo "Caching db dump from IA..."
	@test -f data.sql || \
		(curl --progress-bar -L $(SRC_DATA) -o data.sql.gz && \
		gunzip data.sql.gz)

build:
	@docker build --tag $(NAME) .

debug:
	xhost +local:
	docker run --rm -it \
		-v $(XSOCK):$(XSOCK) -e DISPLAY=$${DISPLAY} \
		dina/specify-desktop:v6

up:
	@echo "Launching Specify db"
	docker-compose up -d db

	@echo "Launching Specify 6 UI"
	xhost +local:
	docker-compose up ui

get-s6-login:
	@echo "Getting Specify 6 username from db... did you export the .env?"
	#@export $(cat .env | xargs) > /dev/null
	@docker exec -i specifydesktopdocker_db_1 \
		sh -c "mysql --silent -u root -p$(MYSQL_ROOT_PASSWORD) -D$(MYSQL_DATABASE) \
		-e 'select name, password from specifyuser where SpecifyUserID = 1;'"


clean:
	#rm -f Specify_unix_64.sh
	docker-compose stop
	docker-compose rm -vf

release:
	docker push $(NAME)
