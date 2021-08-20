# Custom shared libraries directory names 
SHARED_LIBS = utils

# ==============================================================================================

# Every module's directory name
DIRECTORIES = $(SHARED_LIBS) $(foreach lib, $(SHARED_LIBS), \
	$(patsubst lib, ' ', $(shell find . -maxdepth 1 -type d -name '[!.]*' | tr './\n' ' ')))
	
# ==============================================================================================

all:
	@for dir in $(DIRECTORIES); \
	do \
		cd $$dir; \
		make -s $@; \
		cd ..; \
	done; \
	echo "Make $@ was succesfull"

clean: 
	@for dir in $(DIRECTORIES); \
	do \
		cd $$dir; \
		make -s $@; \
		cd ..; \
	done; \
	echo "Make $@ was succesfull"

help:
	@echo "COMMANDS: " 
	@echo "     make / make all -- Compiles all projects in current directory"
	@echo "     make clean      -- Cleans all projects in current directory"
	
