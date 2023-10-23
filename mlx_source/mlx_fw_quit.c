/**
 * @file mlx_fw_quit.c
 * @author andreyvdl (https://github.com/andreyvdl)
 * @brief Function that ends the mlx.
 * @version 0.1
 * @date 2023-10-22
 * @copyright Copyright (c) 2023
 */

#include "../mlx_include/mlx_framework.h"

void mlx_fw_quit(void *mlx_win)
{
    SDL_Window   *window = (SDL_Window *)mlx_win;
    t_string     error = NULL;

    SDL_DestroyWindow(window);
    error = (t_string)SDL_GetError();
    if (*error != 0)
    {
        dprintf(STDERR_FILENO, "SDL error: %s\n", error);
    }
    SDL_Quit();
}
