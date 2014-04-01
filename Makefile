SRC = $(wildcard lib/*/*.js)
CSS = $(wildcard lib/*/*.css)
HTML = $(wildcard lib/*/*.html)
COMPONENTJSON = $(wildcard lib/*/component.json)
TEMPLATES = $(HTML:.html=.js)

deploy: build
	@echo Deploying
	rm -fdr ../portfolio/source/StateMonitor
	cp -R . ../portfolio/source/StateMonitor

build: components $(SRC) $(CSS) $(TEMPLATES)
	@component build

components: component.json $(COMPONENTJSON)
	@echo These two wont behave, and needed to be installed manually...
	@component install component/to-function component/event
	@echo installing everything else...
	@component install

%.js: %.html
	@echo converting $<
	@component convert $<

minify:
	@component build --use component-minify

clean:
	@echo cleaning
	rm -fr build components $(TEMPLATES)

.PHONY: clean minify
