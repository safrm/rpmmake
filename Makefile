MARKDOWN = markdown
MDDOCS   = $(wildcard *.md)
HTMLDOCS = $(MDDOCS:%.md=doc/htmlpages/%.html)

doc/htmlpages/%.html: %.md
	$(MARKDOWN) $< > $@ || rm -f $@

all: $(HTMLDOCS)
	 [ -a jss-docs-update ]; then jss-docs-update ./doc ; fi


clean:
	rm -fr $(HTMLDOCS)

