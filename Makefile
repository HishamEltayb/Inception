
build:
	docker build -t testdb .

run:
	docker run -it --name testdb testdb

clean:
	-docker stop testdb
	-docker rm testdb

fclean:
	-docker rmi testdb
	
down: clean fclean

up: build run

re: down up
	
	
.PHONY: build run clean fclean down up re