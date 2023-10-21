CYAN=\033[36m
RESET=\033[0m
GREEN=\033[32m
YELLOW=\033[33m

ifeq ($(shell ls /bin/echo), /bin/echo)
	ECHO=/bin/echo -e
else ifeq ($(shell ls /usr/bin/echo), /usr/bin/echo)
	ECHO=/usr/bin/echo -e
endif

all: SDL/build/libSDL3.so

pull_SDL:
	@${ECHO} "${CYAN}Pulling SDL...${RESET}"
	@git submodule init
	@git submodule update --remote SDL
	@${ECHO} "${GREEN}Done!${RESET}"

SDL/build/libSDL3.so:
	@${ECHO} "${YELLOW}If it result in an error run 'make pull_SDL' and try" \
	"again.${RESET}"
	@${ECHO} "${CYAN}Building SDL...${RESET}"
	@cmake -S SDL -B SDL/build && cmake --build SDL/build
	@${ECHO} "${GREEN}Done!${RESET}"

clean_SDL:
	@${ECHO} "${CYAN}Cleaning SDL...${RESET}"
	@make -C SDL/build clean --no-print-directory
	@${ECHO} "${GREEN}Done!${RESET}"

re_SDL: clean_SDL pull_SDL SDL/build/libSDL3.so

.PHONY: pull_SDL clean_SDL re_SDL all
