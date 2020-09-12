SLACKCAT := slackcat --tee --channel isucon10-kyoto-sweets
SLACKRAW := slackcat --channel isucon10-kyoto-sweets

PPROF:=go tool pprof -png -output pprof.png http://localhost:6060/debug/pprof/profile

PROJECT_ROOT:=/home/isucon/isucari
BUILD_DIR:=/home/isucon/isucari/webapp/go
BIN_NAME:=isucari

NGX_LOG := /var/log/nginx/access.log

BUILD_DIR:=/home/isucon/isucari/webapp/go
BIN_NAME:=isucari

all:
	@echo 'Not configure. all'

.PHONY: buid
build:
	cd $(BUILD_DIR); \
	go build -o $(BIN_NAME)

restart: 
	sudo systemctl restart isucari.golang.service

git-pull:
	git pull origin $(git rev-parse --abbrev-ref HEAD)

.PHONY: log
log: 
	sudo journalctl -u isucari.golang -n10 -f

deploy: git-pull build restart

kataru:
	sudo cat $(NGX_LOG) | kataribe -f ./kataribe.toml | $(SLACKCAT)

pprof:
	$(PPROF)
	$(SLACKRAW) -n pprof.png ./pprof.png

git-setup:
	git init
	git config user.name "seeds-std"
	git config user.email "info@seeds-std.co.jp"
	git remote add origin git@github.com:kawakattsun/isucon10-qualify.git

# https://github.com/matsuu/kataribe#nginx
kataribe-setup:
	wget https://github.com/matsuu/kataribe/releases/download/v0.4.1/kataribe-v0.4.1_linux_amd64.zip -O kataribe.zip
	unzip -o kataribe.zip
	sudo mv kataribe /usr/local/bin/
	sudo chmod +x /usr/local/bin/kataribe
	rm kataribe.zip
	kataribe -generate

slackcat-setup:
	wget https://github.com/bcicen/slackcat/releases/download/v1.6/slackcat-1.6-linux-amd64 -O slackcat
	sudo mv slackcat /usr/local/bin/
	sudo chmod +x /usr/local/bin/slackcat
	slackcat --configure

setup: git-setup kataribe-setup slackcat-setup