shader_type canvas_item;

uniform vec4 base_color : hint_color = vec4(0.0, 0.7, 1.0, 1.0);
uniform vec4 glow_color : hint_color = vec4(0.9, 0.2, 0.8, 1.0);
uniform float pixel_size : hint_range(1.0, 20.0) = 2.0;
uniform float scan_line_intensity : hint_range(0.0, 1.0) = 0.3;
uniform float noise_intensity : hint_range(0.0, 0.3) = 0.1;
uniform float time_scale : hint_range(0.1, 3.0) = 1.0;

// Ограниченная ретро-палитра Atari
vec3 atari_palette(vec3 color) {
    // Ограничиваем до 8 цветов (как у настоящего Atari)
    vec3 c = floor(color * 2.0) / 2.0;

    // Добавляем небольшой блум для неонового эффекта
    float luminance = (c.r + c.g + c.b) / 3.0;
    c += glow_color.rgb * luminance * 0.5;

    return c;
}

// Случайные числа для шума
float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    // Пиксельный эффект
    vec2 pixelated_uv = floor(UV * TEXTURE_PIXEL_SIZE / pixel_size) * pixel_size / TEXTURE_PIXEL_SIZE;

    // Добавляем искажение, похожее на старые CRT
    float distortion = sin(pixelated_uv.y * 10.0 + TIME * time_scale) * 0.01;
    pixelated_uv.x += distortion;

    // Основной цвет + пульсация неона
    vec3 color = texture(TEXTURE, pixelated_uv).rgb;
    float pulse = (sin(TIME * time_scale) * 0.5 + 0.5) * 0.3 + 0.7;
    color = mix(color, base_color.rgb * pulse, 0.3);

    // Скан-линии (как на старых CRT-мониторах)
    float scan_line = sin(UV.y * TEXTURE_PIXEL_SIZE.y * 320.0) * 0.5 + 0.5;
    color = mix(color, color * scan_line, scan_line_intensity);

    // Добавляем шум как у старых систем
    float noise = rand(UV + vec2(TIME * time_scale, TIME * time_scale)) * noise_intensity;
    color += noise;

    // Применяем ретро палитру
    color = atari_palette(color);

    // Эффект неонового свечения
    float glow = 0.0;
    for(float i = -2.0; i <= 2.0; i++) {
        for(float j = -2.0; j <= 2.0; j++) {
            vec2 offset = vec2(i, j) * pixel_size / TEXTURE_PIXEL_SIZE;
            glow += texture(TEXTURE, pixelated_uv + offset).a;
        }
    }
    glow = glow / 25.0;

    // Смешиваем основной цвет с неоновым свечением
    color = mix(color, glow_color.rgb, glow * 0.3);

    // Финальное изображение
    COLOR = vec4(color, texture(TEXTURE, pixelated_uv).a);
}
