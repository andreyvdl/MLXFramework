/**
 * @file mlx_framework.h
 * @author andreyvdl (https://github.com/andreyvdl)
 * @brief main include file for mlx framework
 * @version 0.1
 * @date 2023-10-21
 * @copyright Copyright (c) 2023
 */

#ifndef MLX_FRAMEWORK_H
# define MLX_FRAMEWORK_H

/* Includes ================================================================ */

# include <stdint.h>
# include <stdio.h>
# include <unistd.h>

# include "../SDL/include/SDL.h"

/* User Types ============================================================== */

/**
 * @brief Color struct.
 *
 * @param red The red value 0-255.
 * @param green The green value 0-255.
 * @param blue The blue value 0-255.
 * @param alpha The alpha value 0-255.
 */
typedef struct s_mlx_color
{
	uint8_t red;
	uint8_t green;
	uint8_t blue;
	uint8_t alpha;
} t_mlx_color;

/**
 * @brief Struct for window size.
 *
 * @param width The window width.
 * @param height The window height.
 */
typedef struct s_mlx_win_size
{
	uint32_t width;
	uint32_t height;
} t_mlx_win_size;

/**
 * @brief just an abstraction of (char *).
 */
typedef char * t_string;

/**
 * @brief This function initiates the mlx framework and creates a window.
 * @attention For now it prints a error message when a error is detected. In
 * the future this will not happen and the dev is responsabile for detecting
 * errors with mlx_fw_get_error().
 *
 * @param win_size The window size as width and height.
 * @param title The title of the window.
 * @return A pointer to the window on success or NULL if any error is detected.
 *
 * @see mlx_fw_quit().
 */
void *mlx_fw_init(t_mlx_win_size win_size, t_string title);

/**
 * @brief This function tries to free the memory allocated by mlx_fw_init().
 *
 * @param mlx_win The window pointer returned by mlx_fw_init().
 *
 * @see mlx_fw_init().
 */
void mlx_fw_quit(void *mlx_win);

#endif
