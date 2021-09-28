# Uses bash instead of sh 
SHELL = bash
 
# Custom shared libraries
SHARED_LIBS = utils

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
UTILS_TASKS = utils/.vscode/tasks.json
TASKS = .vscode/tasks.json
DEBUG = .vscode/launch.json 

# SED References
SED_WORKSPACE_DIRS = workspace_folders:
SED_DEPENDANCIES = dependencies:
SED_TASK =build_tasks:
SED_TASKS_CHAIN = tasks_chain

# ===============================================================================================================

all:
	@for dir in $(DIRECTORIES);		\
	do 								\
		cd $$dir; 					\
		make -s $@; 				\
		cd ..; 						\
	done; 							\
	echo "Make $@ was succesfull"

#p: project
project:
	@mkdir $(name) $(name)/$(SRC) $(name)/$(CONFIG)  $(name)/$(TESTS)
	
	@touch $(name)/$(CONFIG)/$(name).config  	\
	       $(name)/$(CONFIG)/$(name).log		\
		   $(name)/$(SRC)/main.c 				\
		   $(name)/$(SRC)/main.h 				\
		   $(name)/$(TESTS)/tests.c 			\
		   $(name)/$(TESTS)/tests.h

	@cp -R $(BASE_PROJECT)/.vscode $(name)
	@cp -r $(BASE_PROJECT)/makefile $(name)/makefile

	@sed -i 's/$(BASE_PROJECT)/$(name)/g' $(name)/$(TASKS)	
	@sed -i 's/$(BASE_PROJECT)/$(name)/g' $(name)/$(DEBUG)
	@sed -i '/$(SED_WORKSPACE_DIRS)/a \\t	{"path": "$(name)"},' $(WORKSPACE).code-workspace
	@sed -i '/$(SED_TASKS_CHAIN)/a \\t 	"dependsOn": ["Build $(name) for build all"], ' $(UTILS_TASKS)
	@sed -i '/$(SED_TASKS_CHAIN)/d' $(UTILS_TASKS) 
	@sed -i '/$(SED_TASK)/a 													\
				//$(name)BuildTaskStart											\
			{ 																	\
				"label": "Build $(name) for build all", 						\
				"type": "shell", 												\
				"command": "make all", 											\
				"options": { 													\
					"cwd": "$${workspaceFolder:$(name)}" 	 					\
				}, 																\
				"isBackground" : true,											\
				"group": "build", 												\
				"problemMatcher": { 											\
					"base": "$$gcc", 											\
					"fileLocation": ["relative", "$${workspaceFolder:$(name)}"] \
				}, 																\
				"presentation": { 												\
					"echo": true, 												\
					"reveal": "never", 											\
					"focus": false, 											\
					"panel": "shared",											\
					"showReuseMessage": true,									\
					"clear": false 												\
				},\
				"dependsOn": ["Build Utils for build all"],			// $(SED_TASKS_CHAIN)			\
			},																	\
				//$(name)BuildTaskEnd' $(UTILS_TASKS)
	@sed -i '/$(SED_DEPENDANCIES)/a \\t			"Build $(name) for build all",' $(UTILS_TASKS)
	
del: delete
delete: $(BASE_PROJECT)
	@sed -i '/$(name)BuildTaskStart/,/$(name)BuildTaskEnd/d' $(UTILS_TASKS)
	@sed -i '/{"path": "$(name)"},/d' $(WORKSPACE).code-workspace
	@sed -i '/"Build $(name) for build all"/d' $(UTILS_TASKS)

	@rm -fr $(name)

clean: 
	@for dir in $(DIRECTORIES); 	\
	do 								\
		cd $$dir; 					\
		make -s $@; 				\
		cd ..; 						\
	done; 							\
	echo "Make $@ was succesfull"

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
