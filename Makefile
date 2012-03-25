.DEFAULT_GOAL := install

.PHONY: install uninstall

links = $(shell find $(1) -type f -name "*.symlink")
symlink = $(shell find $(1) -type f -name "$(patsubst .%,%.symlink,$(2))" | sed "s@^./@$(PWD)/@")
map = $(patsubst %.symlink,$(HOME)/.%,$(notdir $(1)))

SYMLINKS = $(shell find $(HOME) -maxdepth 1 -type l -name "\.*" -lname "$(PWD)/*")
BACKUPS = $(shell find backup -maxdepth 1 -type f -name "\.*" ! -name ".gitkeep")
DOTS = $(call map, $(call links, src)) \
		$(call map, $(call links, local))

$(DOTS):
	@@if [ "$(shell readlink $@)" != "$(call symlink,.,$(@F))" ]; then \
		[ -f "$@" ] && mv $@ backup/$(@F); \
		ln -s $(call symlink,.,$(@F)) $@; \
		echo "ln -s $(call symlink,.,$(@F)) $@"; \
	fi

install:: $(DOTS)

uninstall::
	@@if [ "$(SYMLINKS)" ]; then \
		rm -f $(SYMLINKS); \
		echo "rm -f $(SYMLINKS)"; \
	fi
	@@if [ "$(BACKUPS)" ]; then \
		mv $(BACKUPS) $(HOME)/; \
		echo "mv $(BACKUPS) $(HOME)/"; \
	fi
