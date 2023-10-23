/**
 * @file mlx_fw_init.c
 * @author andreyvdl (https://github.com/andreyvdl)
 * @brief Function that start the mlx.
 * @version 1.0
 * @date 2023-10-21
 * @copyright Copyright (c) 2023
 */

#include "../mlx_include/mlx_framework.h"

void *mlx_fw_init(t_mlx_win_size win_size, t_string title)
{
    SDL_Window      *window = NULL;
    SDL_DisplayMode display;
    int             error = 0;

    if (title == NULL)
    {
        title = "";
    }
    error = SDL_GetCurrentDisplayMode(0, &display);
    if (error)
    {
        dprintf(STDERR_FILENO, "SDL error: %s\n", SDL_GetError());
        return (NULL);
    }
    error = SDL_Init(SDL_INIT_VIDEO | SDL_INIT_EVENTS);
    if (error)
    {
        dprintf(STDERR_FILENO, "SDL error: %s\n", SDL_GetError());
        SDL_Quit();
        return (NULL);
    }
    window = SDL_CreateWindow(title, SDL_WINDOWPOS_UNDEFINED,
        SDL_WINDOWPOS_UNDEFINED, win_size.width, win_size.height,
        SDL_WINDOW_SHOWN);
    if (window == NULL)
    {
        dprintf(STDERR_FILENO, "SDL error: %s\n", SDL_GetError());
        SDL_Quit();
        return (NULL);
    }
    return (window);
}
