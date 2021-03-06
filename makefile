# Uses bash instead of sh 
SHELL = bash
 
# Custom shared libraries
SHARED_LIBS = shared

# ===============================================================================================================

# All directories on workspace
DIRECTORIES = $(shell find . -maxdepth 1 -type d -name '[!.]*' | tr './\n' ' ')

# Projects (no shared libraries)
MODULES = $(filter-out $(SHARED_LIBS), $(DIRECTORIES))

# A base project use to create new projects with make project
BASE_PROJECT =$(strip $(word 1, $(MODULES)))

# Name of workspace file
WORKSPACE = $(word 1,$(shell find . -maxdepth 1 -name *.code-workspace | tr './' ' '))

# ===============================================================================================================

# Subdirectories of project
SRC=src
TESTS = src/tests
CONFIG=cfg
.VSCODE=.vscode

# Tasks and Debugg
UTILS_TASKS = shared/.vscode/tasks.json
TASKS = .vscode/tasks.json
DEBUG = .vscode/launch.json 

# SED References
SED_WORKSPACE_DIRS = workspace_folders:
SED_DEPENDANCIES = dependencies:
SED_TASK =build_tasks:
SED_TASKS_CHAIN = tasks_chain

# ===============================================================================================================

all:
	@for lib in $(SHARED_LIBS);		\
	do 								\
		make --no-print-directory -C $$lib $@;			\
	done; 							
	@for dir in $(MODULES);			\
	do 								\
		cd $$dir; 					\
		make  $@; 				\
		cd ..; 						\
	done; 							\
	echo "Make $@ was succesfull"

clean: 
	@for dir in $(DIRECTORIES); 	\
	do 								\
		cd $$dir; 					\
		make -s $@; 				\
		cd ..; 						\
	done; 							\
	echo "Make $@ was succesfull"

p: project
project:
	@mkdir $(name) $(name)/$(SRC) $(name)/$(CONFIG) 

	@touch $(name)/$(CONFIG)/$(name).config  	\
	$(name)/$(CONFIG)/$(name).log		\
	$(name)/$(SRC)/main.c 				

	@cp -R $(BASE_PROJECT)/.vscode $(name)
	@cp -r $(BASE_PROJECT)/makefile $(name)/makefile

	@echo "/*  This is an example  */" >> $(name)/$(SRC)/main.c  
	@echo "" >> $(name)/$(SRC)/main.c  
	@echo "int main(int arg, char* argv[]){ " >> $(name)/$(SRC)/main.c
	@echo "    return 0;" >> $(name)/$(SRC)/main.c 
	@echo "}" >> $(name)/$(SRC)/main.c

	@sed -i 's/$(BASE_PROJECT)/$(name)/g' $(name)/$(TASKS)	
	@sed -i 's/$(BASE_PROJECT)/$(name)/g' $(name)/$(DEBUG)
	@sed -i '/$(SED_WORKSPACE_DIRS)/a \\t	{"path": "$(name)"},' $(WORKSPACE).code-workspace

del: delete

delete: $(BASE_PROJECT)
	@sed -i '/$(name)BuildTaskStart/,/$(name)BuildTaskEnd/d' $(UTILS_TASKS)
	@sed -i '/{"path": "$(name)"},/d' $(WORKSPACE).code-workspace

	@rm -fr $(name)

	@echo "$(name) was removed"



create:
	@clear
	@echo 
	@echo -e " $(BOLDBLUE)Crear entorno para TP $(NC)"
	@echo 
	@echo " - Ingresar nombre de modulo, confirmar con ENTER"
	@echo "   - Recorda que la biblioteca compartida ya esta implementada"
	@echo " - Repetir con todos los modulos" 
	@echo " - Para finalizar pulse ENTER dos veces "
	@echo 
	@echo -e " $(BOLDGREEN)Modulos:$(NC)"
	@while read word; do if [ -z $$word ]; then break;  fi; make project -s name=$$word; done
	@rm -fr project
	@rm README.md
	@rm -fr .git
	@sed -i '/{"path": "project"},/d' $(WORKSPACE).code-workspace

print:
	@echo Directories:  $(DIRECTORIES)
	@echo Modules:      $(MODULES)
	@echo Base Project: $(BASE_PROJECT)
	@echo Custom Libraries: $(SHARED_LIBS)

help:
	@echo ""
	@echo -e "$(BOLDBLUE)COMMANDS: " 
	@echo -e "     $(BOLDGREEN)make$(NC) / $(BOLDGREEN)make all$(NC)    -- Compiles all projects in current directory"
	@echo -e "     $(BOLDGREEN)make clean$(NC)         -- Cleans all projects in current directory"
	@echo -e " 		  "                        	
	@echo -e "     $(BOLDGREEN)make create$(NC)        -- Given user input it creates a coding enviroment "
	@echo -e " 		  "                        	
	@echo -e "     $(BOLDGREEN)make project$(NC)       -- Creates a new project with specified name"
	@echo -e "                           $(BOLDYELLOW)NEEDS ARGUMENT$(NC) - $(MAGENTA)$"name$"$(NC):"
	@echo -e "                           - Example: $(LIGHTCYAN)make project name=Client$(NC)"
	@echo -e " "                         
	@echo -e " "


.PHONY: project clean all delete del p create

# ===============================================================================================================

NC=\033[0m
RED=\033[1;31m
BOLDGREEN=\033[1;32m
MAGENTA=\033[0;95m
BOLDYELLOW=\033[1;93m
BOLDBLUE=\033[1;34m
NORMAL=\033[0m
BOLD=\033[1m
LIGHTCYAN=\033[0;96m

# ===============================================================================================================
