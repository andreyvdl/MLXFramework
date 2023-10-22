ifeq (${shell ls /bin/echo}, /bin/echo)
	ECHO=/bin/echo -e
else ifeq (${shell ls /usr/bin/echo}, /usr/bin/echo)
	ECHO=/usr/bin/echo -e
endif

ifeq (${shell ls /bin/rm}, /bin/rm)
	REMOVE=/bin/rm
else ifeq (${shell ls /usr/bin/rm}, /usr/bin/rm)
	REMOVE=/usr/bin/rm
endif

ifeq (${shell ls /bin/git}, /bin/git)
	GIT=/bin/git
else ifeq (${shell ls /usr/bin/git}, /usr/bin/git)
	GIT=/usr/bin/git
endif

ifeq (${shell ls /bin/cmake}, /bin/cmake)
	CMAKE=/bin/cmake
else ifeq (${shell ls /usr/bin/cmake}, /usr/bin/cmake)
	CMAKE=/usr/bin/cmake
endif

ifeq (${shell ls /bin/make}, /bin/make)
	MAKE=/bin/make
else ifeq (${shell ls /usr/bin/make}, /usr/bin/make)
	MAKE=/usr/bin/make
endif

ifeq (${shell ls /bin/ar}, /bin/ar)
	AR=/bin/ar
else ifeq (${shell ls /usr/bin/ar}, /usr/bin/ar)
	AR=/usr/bin/ar
endif

ifeq (${shell ls /bin/clang}, /bin/clang)
	C_COMPILE=/bin/clang
else ifeq (${shell ls /usr/bin/clang}, /usr/bin/clang)
	C_COMPILE=/usr/bin/clang
else ifeq (${shell ls /bin/gcc}, /bin/gcc)
	C_COMPILE=/bin/gcc
else ifeq (${shell ls /usr/bin/gcc}, /usr/bin/gcc)
	C_COMPILE=/usr/bin/gcc
else ifeq (${shell ls /bin/cc}, /bin/cc)
	C_COMPILE=/bin/cc
else ifeq (${shell ls /usr/bin/cc}, /usr/bin/cc)
	C_COMPILE=/usr/bin/cc
endif

CYAN=\033[36m
RESET=\033[0m
GREEN=\033[32m
YELLOW=\033[33m

NAME=libmlxfw.a
C_MLX_FLAGS=-Wall -Wextra -Werror

all: SDL/build/libSDL3.so ${NAME}

${NAME}: ${MLX_OBJECTS}
	@${ECHO} "${CYAN}putting files in library...${RESET}"
	@${AR} rcs ${NAME} ${MLX_OBJECTS}

%.o: %.c
	@${ECHO} "${CYAN}Compiling $<...\n${RESET}"
	@${C_COMPILE} ${C_MLX_FLAGS} -c $< -o $@

pull_SDL:
	@${ECHO} "${CYAN}Pulling SDL...${RESET}"
	@${GIT} submodule init
	@${GIT} submodule update --remote SDL
	@${ECHO} "${GREEN}Done!${RESET}"

SDL/build/libSDL3.so:
	@${ECHO} "${YELLOW}If it result in an error run 'make pull_SDL' and try" \
	"again.${RESET}"
	@${ECHO} "${CYAN}Building SDL...${RESET}"
	@${CMAKE} -S SDL -B SDL/build && cmake --build SDL/build
	@${ECHO} "${GREEN}Done!${RESET}"

clean_SDL:
	@${ECHO} "${CYAN}Cleaning SDL...${RESET}"
	@${MAKE} -C SDL/build clean --no-print-directory
	@${REMOVE} -fr SDL/build
	@${ECHO} "${GREEN}Done!${RESET}"

re_SDL: clean_SDL pull_SDL SDL/build/libSDL3.so

.PHONY: pull_SDL clean_SDL re_SDL all
