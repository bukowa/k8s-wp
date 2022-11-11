
.PHONY: test

test:
	docker run --rm -it \
	--volume="${PWD}:/app" \
	--workdir=/app \
	--network=host \
	--user=$(id -u):$(id -g) \
	seleniumbase \
	pytest basic_test.py --browser=firefox --headless --dashboard --html=dashboard.html